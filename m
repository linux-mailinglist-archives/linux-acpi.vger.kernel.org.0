Return-Path: <linux-acpi+bounces-11128-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F7A32D71
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 18:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AE3A390E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A12821D5B8;
	Wed, 12 Feb 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Un9xLCGe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9C2135A1
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381250; cv=none; b=S1wY8mNyPlSPc74lloPg8fWYLnbI1jtWxBzMCKBluzQhI+WQ10xOSWJPel0fDad46fbVrqaUNDRDp83taEFNC2+2lNcJ7gC0zhDL73YkmAqIOdqWHo+LK7KznM4SLVTfwqwsbbeOgc2ExeZr8rOfiJP3nLqYTjANkN7StymmvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381250; c=relaxed/simple;
	bh=WsXNicR6jaNblz/mUCSZP8cRv1n93+uq/dm06XHfv0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIZPX/12KOoHLzBGew/1t+M9aVLHeGT8NZWZPoJqsLRoM90MsEAIsYvsx4REsybyJ6cd4syGhxDrDhYcHo4/CFI9LfNdXkcp6FLXbgt7P7eWgIl7iwiqdqhK68f5tcxarj0gTfOyEXY3xiFjkHIuhlqKkqJAkw5dIj1w0HX0nXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Un9xLCGe; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8e8445219so361426d6.0
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 09:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739381247; x=1739986047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Smy8Ep/libgaUjooQcIAevVXF9JphJMkMPuXMpEKUoA=;
        b=Un9xLCGeGk4fjQ7rrIapXM7AwPTJlx0pWcUHKUkJVCXfvqDFSyiOUyir8IHkoqRyuc
         RUz2hVurCwSvt7AdqCWuWseEnVG3wN0HyeuRXdxrrXJulbz+NFR14Qt8IvT2NORqykbn
         WqGALU6YCKjasn+8J2m61XnRDKY+mGS9O89XNB3UqUVhnKizSXPPbYExfpylku7/qDj1
         MBYmHyqawsk4G9iSL/ze9+kwmVFqz4e6caln+V2XgU6/eSQY5tqv/AD+6kATXro5RlWg
         50iZbbmvOs0uz/j/QOebHMQy58X119ndFkVkJHcKsMSGENzRmRamXXNqy9Uk6aDYPHAH
         ZMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381247; x=1739986047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smy8Ep/libgaUjooQcIAevVXF9JphJMkMPuXMpEKUoA=;
        b=a5AhUWtqndx5H2k+tRL8/UkMBOOeN5Bn2+aPMJiK4juhqLKu0UEzidgbguH6lw81E+
         dvzo6K2MhRlBFB34iz0xB8mUAwPJgA9M1UuEbUUJwhqm4WPusBVoDaH3xccMHAr1MsqV
         9/zC/3WOTzCvvgx4Yrt17mkiygwiGoWySvo9PRKgDSeOommFDITwpu299uBayFZArPY5
         YV/0CAqlvtToOHxu5zy7tCufp7CU2+Lbbbc0lTZsF74Scm82flrge7RQIwSfxJNj263B
         a4HUDKOk+5dwHZMJl5hRzfPp8tBtWeL/iMPJXFi4d+DM9ZfEaGqeQj9rgvGP55vwxNuw
         bX2A==
X-Forwarded-Encrypted: i=1; AJvYcCXaVJvLn6WjPvgzoO32jSSBRvMuth3C7j3JNewhw5kG1evfOy+TdLA5fK8Mb3apxnx51z/1ZwdMjsnu@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMygcF/K3locWaZzPn6ssxLhC/aYBTfoWDrQUvNiJnoSotYwW
	8s134N9Jc8CtWpLqYDtxPKUQcviTfyF8aPt8f1bGtGom4N3aLRCVUo4947jK6xA=
X-Gm-Gg: ASbGncvK2onwPXhpkhj2B/I6zzWAGWlQli38J5xiKD/PxvrmLIOrmBmVSP+608Ys1v3
	eBAbRnaAtFQdtwn1zBWqmqqZYhxmhrEcKJ+nHAUiGkBj/ZXXexGgiTUzlX1d8X0jVTWbScsqeje
	KHNZ6k0cRneSpLeinNhlYTAePJitXyexA8JjD4eNI6ix6aNItQ8oxPSUdQBKOeghCmSuPhApcUZ
	xX8EvvWP3xxphoxZ1a/jhVIDyMgGq6lK6j6500up4K82pHZpNeH3gNblUT9GWu9IuVjggVfP+Qw
	ptSFBgj3exFu6g/8pD+SrAisGFHMlg7yuPPtzU54D7wunUVlGqYKp/iTzbXOWcDoWIW0uwnQPw=
	=
X-Google-Smtp-Source: AGHT+IFxLq/9chQgLM98IqnvfPjNIMr3SqvTbtBXTR+199INYC5w6TgCv988GbjKoOmNdHzhzqWKwA==
X-Received: by 2002:ad4:4348:0:b0:6e6:5bda:a47b with SMTP id 6a1803df08f44-6e65bdaa4e8mr6261416d6.9.1739381247418;
        Wed, 12 Feb 2025 09:27:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65b3df028sm2097176d6.117.2025.02.12.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:27:26 -0800 (PST)
Date: Wed, 12 Feb 2025 12:27:25 -0500
From: Gregory Price <gourry@gourry.net>
To: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com, rafael@kernel.org, lenb@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	honggyu.kim@sk.com, rakie.kim@sk.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Message-ID: <Z6zZ_UqcY9MbyDL1@gourry-fedora-PF4VCD3F>
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
 <Z6HGwq731v+VX1CP@localhost.localdomain>
 <Z6JAicm5VxE6HKnO@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6JAicm5VxE6HKnO@gourry-fedora-PF4VCD3F>

On Tue, Feb 04, 2025 at 11:30:01AM -0500, Gregory Price wrote:
> > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > index 80a3481c0470..cc94cba112dd 100644
> > > --- a/drivers/acpi/numa/hmat.c
> > > +++ b/drivers/acpi/numa/hmat.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/list_sort.h>
> > >  #include <linux/memregion.h>
> > >  #include <linux/memory.h>
> > > +#include <linux/mempolicy.h>
> > 
> > nit: is this #include directive necessary?
> 
> yes because hmat.c now calls
> 	mempolicy_set_node_perf(nid, coord))
> 

apologies, i missed that there were two of these, we'll drop this.

~Gregory

