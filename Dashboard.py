import streamlit as st 
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns
import os
from matplotlib.backends.backend_agg import RendererAgg

@st.cache
def get_data_voltaje():
     return pd.read_csv(os.path.join(os.getcwd(),'datos.csv'))
@st.cache
def get_data_amperaje():
     return pd.read_csv(os.path.join(os.getcwd(),'df_amperaje.csv'))

#Configuracion de la Pagina
st.set_page_config(layout="wide")
#load dataframes
df_data_voltaje = get_data_voltaje()
df_data_amperaje = get_data_amperaje()
st.title('Proyecto Electronica 6')
st.markdown("""Medidor de Calidad y Energia""")

#Graficas
col1, col2 = st.columns([3, 1])
col1.subheader("Amperaje")
col1.line_chart(df_data_amperaje['Valor'])
col2.write(df_data_amperaje['Valor'])

col3, col4 = st.columns([3, 1])
col1.subheader("Voltaje")
col1.line_chart(df_data_voltaje['Dato'])
col2.write(df_data_voltaje['Dato'])







