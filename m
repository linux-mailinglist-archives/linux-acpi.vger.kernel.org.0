Return-Path: <linux-acpi+bounces-7168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B904D9431CF
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E4D286695
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A81B29AF;
	Wed, 31 Jul 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jPWOReDo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4961B3744
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jul 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435314; cv=none; b=EsL+HG4PnBEkXfQRFdf/SkdgPAkx4HXCa5cJz722BMxrUSEgMRuS9DgWowyezt+rM87gXCch2in5QV7VyBK9rz3roXkkCA4zhtZMv7hl1WDCJ3c3CXnGt9+pfMNlBfSeJKEyEPKaI+PAwu7RL0nEn8KCi4vTIm3wSI6XLNBq+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435314; c=relaxed/simple;
	bh=r4t/RSO2hnjEe6G0UZz+W/1GYVcTqgB0/PT6VIY5r9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCWTV9D2mQYAm1KBYAtSe7fzoirZMndyS5XO+ZO5j3ofOQPvm1/35FeJvHwN4MBNm+GtT8goEqnszRxx+5UJcYhJTZL4IHbYJ+SXTltdAaDdIGiIchO2n4hsoodyG5RMVeIwd1jNFmTuS1HgtfobQZLT8X++r5Z2NsCTbgfs/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jPWOReDo; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7aed340daso34782106d6.3
        for <linux-acpi@vger.kernel.org>; Wed, 31 Jul 2024 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722435312; x=1723040112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZoGyjJaWEwHv/KfoCIN2q0gBEBBi+yquexZmDv5wAQ=;
        b=jPWOReDofvGe9fFrLP9YyShxbJFutSpldxfOK/lc83oI+PG114J/apwW/o5BKp2BHu
         XIK1uSQFinqafLqbjZ8p5hHYDiXzstGFzRyZodOtbQ+zXegeQPFCpFJVmf7UILT6GbBq
         x9Cz5p3XVcKRx8F7ZBRGB3X3znna0wLiFiM46MumeX8hsCFqb0ja7CJXpSWrEYpX8qOw
         LKXErYzR9OL47IeAMh7O4vhCN9QHtc3EVXplsuFaUGRIv4rV7fey8aUALT0/0VvItykK
         PJ80qjb+mX6R4aQTL5JuG/tIFsSnzYLW5XG0sNeloVZhBT4b5B8Aa+IL9+sz9B3wGeWS
         dhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435312; x=1723040112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZoGyjJaWEwHv/KfoCIN2q0gBEBBi+yquexZmDv5wAQ=;
        b=jf0BpkeRY+8BF6jL2ffAbYSdHe+Eu0bpLVen9r6/ogzwxp2oa5bCF2a4RN6k+hrpM7
         jGRRW0x5cHkIzITr51YYvKsrARvucL6bJzh714RuTjEoYTS5xgEX7RUI8gSdgdjRw8NG
         WsGW0MzfMMHuPMD1iBC8xLgNSGqu61MvN5i0qPMfF/5G/YFETxPJD5hVUKABr72djB48
         wtd8A69Zqazcb86JnWWkTH3qs6+k8VhUEEddSAMCGagnxeQrKyTIpN822Ip3HynL8p4O
         9F948uHHHVd2ILfX48xAG8KDZos3BugkukeBojUNGSDL6ZiWxpdxpBrA8qsSkSZwLHm/
         7Mjw==
X-Forwarded-Encrypted: i=1; AJvYcCWmi4fdTR5KoTPRXiNOD/AIT5YO4ca/igqxe8TDgqTI7gz22kUn8wqOyk3inUDTmgNLOpZcztofqTQ/gs5yI/Qdr3ElpwcpX2ERCw==
X-Gm-Message-State: AOJu0YzUHqiXQQh4d3BVUiJyNnz8Yn3UAhQxxHHofO1OrKagiFa72AaN
	VIe4PlKUnoSOqPNfZBMjpK8IF6qPoy6BkBq5EPlPQAfAOqyuQY6mBi+ElJjN5iA=
X-Google-Smtp-Source: AGHT+IFNREONZgm7zLR0cLrVINRHZAuZJz57NqpdO1aQ2JjmTspGlBRsHUwaFMQ8H7vcv4eyfHiRWw==
X-Received: by 2002:ad4:5c6f:0:b0:6b5:d9ef:d56d with SMTP id 6a1803df08f44-6bb559c3461mr182732716d6.21.1722435311609;
        Wed, 31 Jul 2024 07:15:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa950a3sm74461836d6.90.2024.07.31.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:15:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:26:06 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <ZqlMXuBxi2oShb-u@PC2K9PVX.TheFacebook.com>
References: <20240726215548.10653-1-gourry@gourry.net>
 <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
 <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqhbePA9Egcxyx7o@PC2K9PVX.TheFacebook.com>
 <87cymupd7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqlF0hn6Jh4Ybl-p@PC2K9PVX.TheFacebook.com>
 <878qxiowmy.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qxiowmy.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Wed, Jul 31, 2024 at 03:20:37PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> >
> > In this case, the system is configured explicitly so that kmem does not
> > manage it. In fact, some systems still cannot be managed with
> > EFI_MEMORY_SP due to hpa!=spa issues that the driver cannot manage.
> 
> Sorry, I don't understand.  IIUC, kmem.c can manage almost any memory
> range via drivers/dax/hmem.  Please check
> 
> drivers/dax/hmem/device.c
> drivers/dax/hmem/hmem.c
> 
> Could you elaborate why kmem.c doesn't work for some memory range?
> 

Sorry I misunderstood, I thought you meant the cxl+kmem/hmem subsystem
interaction and handing configuration of the CXL device over to the
kernel.

The boot parameter is not likely to be a solution for us but I will look
at it.

> > But I think a feature that worked in 5.x should work in 6.x, and right
> > now the change in node placement breaks hardware that worked with 5.x
> > which happened to have broken or missing HMAT.

