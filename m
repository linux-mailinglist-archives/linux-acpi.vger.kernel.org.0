Return-Path: <linux-acpi+bounces-12060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8B2A5B6E1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 03:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D771706A5
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 02:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4B1E7C01;
	Tue, 11 Mar 2025 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CG4ikMwu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCF1DE3B1
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 02:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660978; cv=none; b=gUmO8ALEc7g/gEOybZH9gp7agVACgYHvndlstAGNFCwjKv54g6gmIZZX9bRG0YgyLvVMonZC/H7D3vPs10hysE9Hjk43WVPiWtEK/n+JJLaYLXvv/PMnILwBHktRlWfqaWyj+xVatr8NjGVPxEvtYwlzhx6aMWbh10HFco2ohro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660978; c=relaxed/simple;
	bh=ayQn7cmaD8ZHN9iSLJD53bXwzVAe2nRg8K/OGfo4ezo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb4AkW2Ku3TWyULxOhNCPTdo/cAvlczhPRcA0g824GDdBh1CRey1MZ9kZXVxh6NUIMjMMNXGiLZ9LXJBuL4EmYUGxxD9EzzG6rx4aqpJ9/pA258IuIQXwhZt7bDWqdm8BdSrSgEIfOF97PcTgMV73+b8eq9xfz6OHX6el3ndq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CG4ikMwu; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e1b11859a7so20299446d6.1
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2025 19:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741660975; x=1742265775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLhmxVekInszSwRuSq/Qrb92RROhWIHehhP9/GN0v/o=;
        b=CG4ikMwu2iEPORK+r0N/+WPG41vfWr93SdVgh9etRT3XMExYcmyVlJIvUYzpGeg4Yg
         uYZrYwKx2twSbZAp7jSmjazqOcxcrsLsDPbuXpIw2PFRcpwqSXG3rwfAhk6Nx3kDcOVE
         mPsTnYobH2rsEO/HR8n+o8IGobgxFwO6/aNTrbzFffDUHFXwTO2A/ZG4jsnRJpsyGa5u
         00sv7+JTY1H7nGqun6gB5fXZEIUFK05huskVaG1K2drbroTyvsshoG62i7ueBJkoxuVt
         ZjRAeOaE82WQBw5H8NTFPFXY6rg5ScYDPOIPxplZr9ubz+/zB2oOzpmreWLibxu3qnPL
         tJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660975; x=1742265775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLhmxVekInszSwRuSq/Qrb92RROhWIHehhP9/GN0v/o=;
        b=LUCzlUloGhIlfG7n9wNCX+q8Tn/3t5OhUj7XHnk/TCdxnI+CMZcLljcTDfNyNxh9kJ
         uxXoTkFFRGSIvQhnG0VyPaPpIZQHDli0oc45IjWaKqL0dJsmH9Je99gRjm+hnd53gk5x
         a3BzRo/Lf04EpjxQ3DlousFLUSk1MClMf3wIfhhadMrhwZPiRbtHwvpzLArVbb96uYYP
         2e9sJlArT16Ffk0pP1lyJjXpTVoMVAUDMFs2N+cC6z3tGP2sadKQOXlsfAHFhll26GFs
         I/EzqNINVLg+vmstQYaleAijmt+Uhl+Nzbcqso3LXbWiT3PQIZcG6uBPbmeYGFSI9Bqs
         aNMw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQ5ylFUJUw1ahV9mybCHP7+Vy1g4bt4UEZwEZAx/ak9p/AWPWIxqumdG8hL2rzl+asJHGi20b2Rty@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa19SwC2zYBoH+PlvXaOyFxIDoDPksCt+qkTHDYlvrX4ibXyDG
	phxn+HS/oBSsKqHvMAwvup4WLq+rFFSvBTUWmV4Dlvv8TRv9thX+OhsI5+0Izc8=
X-Gm-Gg: ASbGncsbpd4buyoBNNfdB9p++U755FKKEsUeEFAwO0Ew/Zh5ni9CDTadeH52odEpsa0
	OhwIb2XxnY/aA3T104K4UgX45glQPqNI6jlvRB5Ata2mQgJIUkaA9FeZHmWN8WpsSoxL8u9ORH3
	XJZ9zJfVHwHHaCG8T5xTfHqHeaOiYpGHKVjZ2S1BvGkGIfutdYa6Upx3yyV5JjHd+TfYqP+9Adc
	PeMLKYsqIjIwJHU2t7HHcEBI/yJdgLr0v9NCSwNUh74fP6ZGFsM32QA64qMHszcouF1/amkU74T
	3IDEdkEcNCKhANDiRHrdOVmt3TMZmXdgp7q6FtdfpNw7BO9ixcoS69/bXNg8KxQ7MV/okpce19r
	fNyJlzAVAt9w15Rlz4VXyWAe4owDM0GHZmjpuCw==
X-Google-Smtp-Source: AGHT+IHlLnx/8yc1KdPJ5zdTyNSTraZ5mmTbBV9D2H2GKIWW4SnnOdBFw0C3+8mYsLbkz/bwItoSuQ==
X-Received: by 2002:ad4:5d49:0:b0:6e8:f4f6:9311 with SMTP id 6a1803df08f44-6e9006019c7mr233583136d6.1.1741660975278;
        Mon, 10 Mar 2025 19:42:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090cf8sm65776146d6.34.2025.03.10.19.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 19:42:54 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:42:52 -0400
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
Message-ID: <Z8-jLIugrb86KBSZ@gourry-fedora-PF4VCD3F>
References: <Z871k085e-Th-jTz@gourry-fedora-PF4VCD3F>
 <20250311020806.404-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311020806.404-1-yunjeong.mun@sk.com>

On Tue, Mar 11, 2025 at 11:07:27AM +0900, Yunjeong Mun wrote:
> Hi Gregory,
> 
> In my understanding, both SRAT and CFMWS have the above device and interleave setup.
> 
> and below are the CFMWS configurations (with some unnecessary lines removed):
> 
> [0A4h 0164 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
> [0ACh 0172 008h]         Window base address : 0000002080000000 <- Memory region
> [0B4h 0180 008h]                 Window size : 0000032780000000
> [0BCh 0188 001h]          Interleave Members : 01           <-- 2-way interleave
> [0BDh 0189 001h]       Interleave Arithmetic : 01
> [0C8h 0200 004h]                First Target : 00000043     <-- host bridge id  
> [0CCh 0204 004h]                 Next Target : 00000053     <-- host bridge id 
> 
> ...
> 
> [170h 0368 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
> [178h 0376 008h]         Window base address : 0000064F80000000
> [180h 0384 008h]                 Window size : 0000033000000000
> [188h 0392 001h]          Interleave Members : 01          <-- 2-way interleave
> [189h 0393 001h]       Interleave Arithmetic : 01
> [194h 0404 004h]                First Target : 00000143    <-- host bridge id
> [198h 0408 004h]                 Next Target : 00000153    <-- host bridge id
>

Are you able to share all CXL Fixed Memory Window Structures in the
CEDT?  Just want to confirm some suspicions here about why we're seeing
12 NUMA nodes.  This explains 2 and suggests there's at least 4 host
bridges - but not the other 8.

~Gregory

