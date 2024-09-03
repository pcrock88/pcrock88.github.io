import os 
import glob
import sys



def run(file_feature,dst_path):
    """ 
    file_feature_name: 文件特征，比如"新手拾遗系列-xxx"  新手拾遗系列* 

    类似的 xxx.png 可以设置为 *.png

    dst_path: 目标文件路径, 用于显示md图片
    """
    file_names:list[str]=glob.glob(file_feature)
    # ![2022尼斯海域攻略](.\imgs\2022尼斯海域攻略.jpg) 
    if not os.path.exists(dst_path):
            os.makedirs(dst_path)
    relative_path = os.path.relpath(dst_path, __file__).replace("\\","/")
    # docsify 无法识别 \ 格式路径
    relative_path_base = os.path.join(
        '../' * len(tuple(filter(lambda x :x!="..",relative_path.split('/')))) , "_media",
    )
    for fname in file_names:
        # 带空格文件无法识别
        if fname.count(" "):
            _fname,fname = fname,fname.replace(" ","-")
            os.rename(_fname,fname)    
        # img_path = os.path.join(relative_path_base,fname)
        img_path =f"{relative_path_base}/{fname}"
        fname_prefix = fname.split(".",1)[0]
        img_str:str= f"![{fname_prefix}]({img_path})"
        md_name = f"{fname_prefix}.md"
        md_path = os.path.join(dst_path,md_name)
        if os.path.exists(md_path):
             continue
        with open(md_path,"w",encoding="utf8") as f:
             f.write(img_str)

    

    

if __name__ == "__main__":
    file_feature = "套装搭配*"
    prefix  = "..\\"  # dst_path 以_media为当前目录,所以 ..\ 是必须的
    _dst_path = r"新人/基础知识" # 相对路径
    dst_path = f"{prefix}{_dst_path}"
    """ 
    eg:
    file_feature = "新手拾遗*"
    _dst_path = r"新人\新人必看\新手拾遗系列")
    """
    run(file_feature,dst_path)
    