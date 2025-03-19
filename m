Return-Path: <linux-acpi+bounces-12351-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87897A69226
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4B11730FD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE461D7E5F;
	Wed, 19 Mar 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bK3QZkiu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FC1D63E3
	for <linux-acpi@vger.kernel.org>; Wed, 19 Mar 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396072; cv=none; b=oFAvl0ZqUyXxp9USqFf3Py31tHFpu3npK+jog/tS+CjDl6iX2pTtH0VHpjytwFN8tuBWiCTj9BpCiS//vZB+ObMvvbXMVouP/UkPGd2qHGLZBU31SZqEEc2NaMAH8VJy7SfS2UuvClfATVdc0BNZVaMQm62PYVtqPewesjgIWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396072; c=relaxed/simple;
	bh=Z2Il8gtAT9okAlyaIoDCRjMTEEEzJsGP1Iy4uHIEtyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjqecnhHDo5NRP1n5ZrYN072H33wCj+s+GPFggtvWyGM1e4VUYAkWriqxq/G/6IdxKNjd07t2BciV3UJPVr+KYU0eKecI6/c5q3Paii8HCASQyix1QRva3vAByvE4XI1iqHBQuC8hR5/mMK2taSxejPvQdCmnVgl32NDIcjU0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bK3QZkiu; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f05acc13so75613376d6.2
        for <linux-acpi@vger.kernel.org>; Wed, 19 Mar 2025 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742396069; x=1743000869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEG116Bshu/6/Dv1OBb0IEbzcPj4PMnrUj3mfg+RXU8=;
        b=bK3QZkiuPKDM8DJAJxn9YYnn9UefoGVXV3rbkn7k4qMcPB0r2+qPwn9HWyb/srTmbt
         E7oWGiBXq5N9YioPa6pkGrijabH2k5t0E6MnnTQdUvE6Xfn8/JkIJSEJ9/bktulrhFSo
         jLXFbx8NrKY4us30HWgt+Pf9x55Ol4zABU/rHjNBx3tmaUc2JQuXbGSRROqRz3/IuHNY
         n+jvtZubbTyvdf2qy16a8UP7CQzrOUVIUVw86WfK1X6nCHHdKGDs3oT924KmDVYN/EPP
         PMITLSLMHB+3qDijksRlmZZc9EU7u4Oud5VLNTyV4k2MfgF+SY9QhSgxZG2M7XXWUx5P
         LG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396069; x=1743000869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEG116Bshu/6/Dv1OBb0IEbzcPj4PMnrUj3mfg+RXU8=;
        b=BRnP+y4Jd2lKDLw4LCZ138VgC2K+8WvDlBwOuZ2bwNIAo0xSFxX+dqdotl6/m2OCXG
         xoaKP6DywZewWnltpv5NOmdf0dub3sI1S/DQBCI94vxR6ypKsXYSgQxKfGUZBE47ZEZz
         6bBdbt9cKS/7P2WnXiDOPHx275i8V/FEDkLFcnx4wCKySIleiEHOM8bU5F8pUq8p8uP6
         31GblhiAVXxDFPweofsJLCpAknF7AxFifDWteLfbsesJuC9HW3Pfzm3Ncno03f+ns0DQ
         5/yGsQU4/0YEbevhtR1mEA5uQrTOTQTwD5UtZB6Qy+FeKQBdxZLzWlcnQ7n2z4Zjd7PP
         J2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVmNt2pkrpABmgnU6weGMqJZHXWndibp4k0e3rPKmhjqRMhHBbbQ76TtRwE4O8h8tu7Dk4AOstv+guK@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQdu/LauEB9p9M25YCyKUMh9c8Lts7DI2r5ph879wmfTK0E8h
	z5OFmffRBxEp6uM3Xxg4Tza04tPZJ8H1QHIqTIRpP+pC9DT+DmM373ADJNRQZng=
X-Gm-Gg: ASbGncvN1PCglrx4X8uhVdxagg8dL5OA3dXCpRW/HD3svzOJOqw85oDaJrkNCEALZXl
	UvkINSF83Dhtebto+XJbo2Uq7j6mrsmAehGn26IbMMb4WwODMYrgPNwWKQyck/sAni5E90SYpBn
	Z8WFOHOxtlnKHHckcD+rRM3kP3tnZPXiK8K+dRGuL3ZdAEooiDnfzyTFYA1jldkrpbQ9CkL0usF
	183/9gkRma08S1KankLojOuS0TgYBYqc+n2uhxAbOchdwXpqeze15xSXo6h+xLIiQdsD0mYtUcA
	5tXwAnGddONWlGmldMlr1+qLem/QCj7nARvpTA79NgRcGgW1gdj7lAw+ItSsabK8BR9mAWAYllG
	nf4ZJrxtD0pl6OonGDAq9+eHQl+Z6aQk+mVcUDg==
X-Google-Smtp-Source: AGHT+IF+c5EdZFKNAizBy55G6o/Xg1TdvHi/rmDa9Zp63ey0OKoIbypTD3IB4bL6twCtlkAEbu0fNA==
X-Received: by 2002:a05:6214:c6a:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6eb29284aadmr38850666d6.1.1742396069211;
        Wed, 19 Mar 2025 07:54:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade35a8d9sm81204646d6.119.2025.03.19.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:54:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:54:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z9raotkELnHnK19a@gourry-fedora-PF4VCD3F>
References: <Z9mNiWm1pNIxiu0t@gourry-fedora-PF4VCD3F>
 <20250319095630.1075-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319095630.1075-1-yunjeong.mun@sk.com>

On Wed, Mar 19, 2025 at 06:56:21PM +0900, Yunjeong Mun wrote:
> > These are the root decoders that should map up directly with each CEDT
> > CFMWS entry.
> > 
> > 2 of them should have interleave settings.
> > 
> > If you were to then program the endpoint and hostbridge decoders with
> > the matching non-interleave address values from the other CEDT entries,
> > you could bring each individual device online in its own NUMA node.
> > 
> 
> I think this means that I can program the endpoint(=cxl_decoder_endpoint)
> to map to the 8 CFMWS, and the hostbridge decoder (=cxl_decoder switch) to map
> to another 2 CFMWS(cross-host bridge).
> 

you can program any given endpoint decoders to map to either per-device
CFMWS, or to the interleave CFMWS - decoders are flexible in this way.
The existince of both sets gives you the option of how to program the
topology - it's up to you.

~Gregory

