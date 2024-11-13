Return-Path: <linux-acpi+bounces-9528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC19C6802
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 05:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C65FB257CF
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A416C453;
	Wed, 13 Nov 2024 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I2rqHbmU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186FA1632D6
	for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731471323; cv=none; b=FQXtcoLOzcbTxrVvoYFAtgwR/aFkrqkgW7HWq/7vKYdxBdzld3dZ+4faJEr0XChJLQWIHRzNi+ZzafshFiBO73U/kMn4H+x8sdPzu2YRMi62AhOtOOdSWl5KXOh+EbWi1Q4CsDoW52TcPEpwyE1cF+4ecjDK2v0KnmAoQmDYdO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731471323; c=relaxed/simple;
	bh=T2rdd7tXYgiIrzYHzCAL/PU41GbaxiH5Y8Q/Zohq1FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN6W+5kEmwYpf/GtTXVF8i+yR13uRQG3cPyFyILkPMgKq/XyYc4Tb/+UzLjkpMuAncOdTYrWQ/dVcWoZC1Za7kIuuhQ2Zgz4YlzIqFhpqBE5s5dXbowkJO7lsuUdsyZJbMJ1J/DIupPNQKA2k2PnKIvo1Va6CQTNYwDBRwS1IQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I2rqHbmU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b13fe8f4d0so411221085a.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 20:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1731471321; x=1732076121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUb1WojSD+HhOKe+sBVX703ySuQYQJYEhxr/ZtFrr20=;
        b=I2rqHbmUPI8ue4wAeGFlxm4cr/jRTxxfKfLtbSaTS2FjnXx1w9RNgVGXWBs1icirL3
         JKiE4XuouyoF3a+HT2Jj2GL70sEtwkAYZDmtzRM6F9xJcq5xA5bwQVcA4DUzgmi5KKJD
         ySfDc8lieJklBiOzxSYFQSLlEOz5hBgPA+/TYQ2YWOqJmvCegWOEzjHlBicqkERK6ibp
         MIULWyX9+46qR/9c1IOZIY63yd08OM6uBZkdz/W1iDyzlOCj/di32v7lxTPSIjuPUmxt
         84vH3qPysyJwoCL/XS97MgvdiXkL7yDxOIh/hyrcsqi9OJs4sfdVY8GApmYzHQWrSZs6
         5PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731471321; x=1732076121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUb1WojSD+HhOKe+sBVX703ySuQYQJYEhxr/ZtFrr20=;
        b=kVqk8pgdc0/fE9xxmOGclWid9PhWdmhCv34wOoT+CCFhi3LYLhLwfIi0GNuA7XHGNV
         V0i2mH3SWc9/YCpkgtbPD4OyV6PLxhybWVSRD8N4MsmWyfBTqJDXptpYF+XmhWD7SjLM
         OkpfZGRxZcg222Z174L6/vCshLyhnteIoGyNNQqt453yjfyDyQCmpoG/MFDlUOG215jg
         Juyw15/VXANtfismPcwYhAqcgJqct9BOvSOchCoNp9+95U6HKeUIIZV3htVIv0x3XgS1
         sFLJxEmgnlgysw2oS71jAaN3R9rKV9Dz5LgygP5p/peUrHgrsfkarJC6er63zoZng/5d
         2FZA==
X-Forwarded-Encrypted: i=1; AJvYcCW1BZIjjN5Tepum3Yq0D1cnv3+QU7fsJl5S89mtllFd33+Che67N98lPn2Zmd9La4mBic1rK2+zxMMf@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxMA5pr2KeSVdwa1T0jt8QGVKyS0J5YsChkGMKNkV2HlJguk2
	i+aoFkIC9bpsy/kpdUxJX9c0bp2eCzq3aVHEWSb+JXxO1RZsMa+tdzMtG/sYsNY=
X-Google-Smtp-Source: AGHT+IFZHlowe441qeuXq5e14Sj+kjnoWxQVfmLizMJ+32RwzXsN2gXKawIsTikUmXrXXVOr5Z+7Jw==
X-Received: by 2002:a05:6214:2f03:b0:6d3:cebc:4cd2 with SMTP id 6a1803df08f44-6d3dd06b5b9mr18850226d6.34.1731471320966;
        Tue, 12 Nov 2024 20:15:20 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac44082sm652302085a.38.2024.11.12.20.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 20:15:20 -0800 (PST)
Date: Tue, 12 Nov 2024 23:14:55 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v6 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZzQnvzPLsamSs7i4@PC2K9PVX.TheFacebook.com>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-2-gourry@gourry.net>
 <6733c86390c40_10bc62945f@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733c86390c40_10bc62945f@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Nov 12, 2024 at 01:28:03PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > Hotplug memory sources may have opinions on what the memblock size
> > should be - usually for alignment purposes.  For example, CXL memory
> > extents can be 256MB with a matching alignment. If this size/alignment
> > is smaller than the block size, it can result in stranded capacity.
> > 
> > Implement memory_block_advise_max_size for use prior to allocator init,
> > for software to advise the system on the max block size.
> > 
> > Implement memory_block_probe_max_size for use by arch init code to
> > calculate the best block size. Use of advice is architecture defined.
> > 
> > The probe value can never change after first probe. Calls to advise
> > after probe will return -EBUSY to aid debugging.
> > 
> > On systems without hotplug, always return -ENODEV and 0 respectively.
> 
> Should the advice just succeed when the result does not matter?
> 

I figure at some point during __init the value will be probed and subsequent
calls will be ignored. I'd rather fail explicitly in that case to assist
debugging - otherwise it might be a little maddening to discover your callsite
is too late in the process.

> Otherwise, it depends on the caller to not care based on config.
> 
> I do not feel that strongly about it, so either way:
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>

