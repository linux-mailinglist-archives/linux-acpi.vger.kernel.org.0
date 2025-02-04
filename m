Return-Path: <linux-acpi+bounces-10893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039ACA2772A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 17:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59163A5ED7
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F712153F9;
	Tue,  4 Feb 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rITZ5tH1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868B215165
	for <linux-acpi@vger.kernel.org>; Tue,  4 Feb 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686610; cv=none; b=YDfgVE0S7tCRms/zNuOWMTAET3r0ANlkNWj5myrjxTcNHqyrtvIKD8iWXBQEw5m+agY8BTsC0LPRasqUvPv0j+UP6MBtcpdroIYJt+j/W24neabWsCECpbj96KoebnecARLJdXeZZZ+vObm0QoPMQCH3/FxXURf0o52ojR+R1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686610; c=relaxed/simple;
	bh=V1x8m7b7vL2eJxLoRBO9nQ9eFgSItp4xy5V5pKofc5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpDiXboQHSl64RaKx1UKrxeuiafobosyB9BlCQsCaCLH/xn1o7I6adnlgxTIf856aFgoaNu2qx6P6h3LOdYaXRxQ6WkIay67AL6SC94+vVTCr3HElvB4UYPgk/JVQH44HX5yHjPK52/7nirjSOyRJlcM7udFu/iavdkTGKOIIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rITZ5tH1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so47378626d6.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Feb 2025 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738686605; x=1739291405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D71GlxrE7tpGvGKymFaxu1Uf5BNrF3hZ/vpbqLGWS1M=;
        b=rITZ5tH1v2E1kf170/btnHDYTpp0oIJiNM1ITknozR7VWYBe38MpS6NMYOOduXuZvu
         oebP7k3LmHgQcsLksjeO3/suiYUw6qfBTL/k5e3vCUS8WFXQNh/C4iTe11HBt9owUfak
         SwDXheDtgAMHZZdOo57TwFdP+Bptf07Lx1Pk6beAtnCdVS3N82KHJOc0nsGFz/zueR3u
         QJ4p2nFIzK1ulnwy7exdoYexPL7i01MNjPszJXKV/WHrZNcuqE6JPogpkSeh1LK1fcvZ
         illjenTYQUZoGwtrdZl6wgosLujhaAZA5hKPkcA31WUgWCjI4qnD+neI1QsWFmqEPOHD
         +Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686605; x=1739291405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D71GlxrE7tpGvGKymFaxu1Uf5BNrF3hZ/vpbqLGWS1M=;
        b=F6NrlatjbSbAk3T449lxFoL7jz0uNJozlH0tgsW8yIrZES9th1CbwSqNGhWSb48pPz
         /R7WchbiBcWua3cEfUMhdNsk2vlE8OeHAWyLCDmayitLdWh/fSaRwcLI1cyOJAOU5+Oq
         tHp4Pxl6IfiElssyUZC2hd+uUse0ZMkiKTNK2aI3vvYZJTh+F6Jbxjls3nGNcdOWuzr5
         rUGqn32quvQK2OpjV7evzSjP8JPyFNSboTgnC/BGUnNVIJciP3pS+D+mj2fd90VwaFK3
         jGXeB89+swY+JSEzC/rR3T7+XGtCsmFoRkwHKmFy2ATMXhdlNuR1EAuIVwayRY0PDefY
         UIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr9damCbCwsHyO0nTggGnry43THVaXZ8uaJPU4jtMpPasX9EnkQjy7wSDg6ViP06BGlXdmvHYKi4U6@vger.kernel.org
X-Gm-Message-State: AOJu0YwoL0SgjFnT9rd2yhHhVeTNKvYn3jDTGOHbiLuUezNLl7pLiTz9
	bnjKgwPi0+zYejZb8p8IdUaT83kv7FU3uHYOYzE7vfsywHhrZskLYtGdlcQkUtE=
X-Gm-Gg: ASbGnctu5D0alyXWcda5m4OhILoWQHX4bBXw60eJNbSMxhnyFL83zqsep9bMsAM3lER
	Ybf1tpyGcGsFolo+rWr5Hd/JGY6wJ1ZsEGmhxmX5pNeUrX2Igx4Ka0BDfRKQ0qxz/0DN6skNLT+
	CQ47ZgXUGBZxmREECac5/a7VGpVKS8r9R7kAc+cq69PR9hV84kfekdf6P8DmiykGv67d5BHQrw8
	B+V7jniRnLyMfnfEUJ8c3Ng8rIRLWneXuOE21cU0h9/w85v13rlJvdw6ZIdKKS7Bv2+ajevIgpM
	qoRUEGC5E6sTaMSM0TmCHAPb/qPAwQ4oKHuBS4kYNYTDHBtNNFjis00Q7X/BxZvXs9BbqMskcg=
	=
X-Google-Smtp-Source: AGHT+IEh7NY7KtYyUy/WcPTOaeu6nFTa5IBV28uuo68I8Z2SH3+2+Dfjrn1+lGtIZSDuaDeya3rq6Q==
X-Received: by 2002:a05:6214:408:b0:6d1:9e72:596a with SMTP id 6a1803df08f44-6e243c7d3bdmr431683986d6.37.1738686604013;
        Tue, 04 Feb 2025 08:30:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2548357f9sm63652056d6.63.2025.02.04.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:30:03 -0800 (PST)
Date: Tue, 4 Feb 2025 11:30:01 -0500
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
Message-ID: <Z6JAicm5VxE6HKnO@gourry-fedora-PF4VCD3F>
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
 <Z6HGwq731v+VX1CP@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6HGwq731v+VX1CP@localhost.localdomain>

On Tue, Feb 04, 2025 at 04:50:26PM +0900, Harry (Hyeonggon) Yoo wrote:
> On Tue, Jan 28, 2025 at 02:23:31PM -0800, Joshua Hahn wrote:
> 
> I believe the author has successfully addressed major concerns
> through the revisions. The interface and the code now look good to me.
> 
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 

Thank you!

> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 80a3481c0470..cc94cba112dd 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/list_sort.h>
> >  #include <linux/memregion.h>
> >  #include <linux/memory.h>
> > +#include <linux/mempolicy.h>
> 
> nit: is this #include directive necessary?

yes because hmat.c now calls
	mempolicy_set_node_perf(nid, coord))

and best practice is to "include what you use" to avoid hidden
dependency issues should another include be removed later.

~Gregory

