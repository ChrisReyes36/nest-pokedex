import { Injectable } from '@nestjs/common';
import axios, { AxiosInstance } from 'axios';
import { HttpAdapter } from '../interfaces/http-adapter.interfaces';

@Injectable()
export class AxiosAdapter implements HttpAdapter {
  private readonly http: AxiosInstance = axios;

  async get<T>(url: string): Promise<T> {
    try {
      const { data } = await this.http.get<T>(url);
      return data;
    } catch (error) {
      console.log(error);
      throw new Error('This is an error - Check logs');
    }
  }
}
