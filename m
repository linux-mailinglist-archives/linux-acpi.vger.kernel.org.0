Return-Path: <linux-acpi+bounces-12322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF688A67780
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 16:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84EA19A602F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1D20E71F;
	Tue, 18 Mar 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qoVWqPUF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D31586C8
	for <linux-acpi@vger.kernel.org>; Tue, 18 Mar 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310803; cv=none; b=FbJ+AEtaNTjL5CJbF4JfSU8g9D+AwdpzvWNLB3WFaphw72/fxBGk4wN7sB6DRDlCr8ZgTTgX7yIMdiI9+VewCtv8kdlCzQl5mumgxzYeCA31PTb+HStqQsbCfI3JSqqKylHCFVz2iaMWu41LqKkzNRoJ0fuezuaQA17BLRrSjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310803; c=relaxed/simple;
	bh=EeDs3BIQGtKIFiUdLNLAGZaKA1a2dW7BiHIddDYGJGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka6tHX226NsXSxoVwzOYE+HkgTyhJYYhDGH5KQSO+iPXpaR2KZ5kN3pXsmDn1WgGrR/vFxXvWPjVL00Pp6Iz1Du+Le6q+ImyuJMYZDmg2JDZAf5aKCTRuSn4F7Gl/16yIpsUMWN8Mjwrqip7T1GLAyzovXGUBOIa0iHTulQEY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qoVWqPUF; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c559b3eb0bso327836785a.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Mar 2025 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742310796; x=1742915596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fq4YIdfyvH3D38tBVB9O/pfTAXZmUQ3xOYQLXZJY38E=;
        b=qoVWqPUFSe0dKI7mmBZxT/BTFvujfxisrax8gVMpOiwFP4ySflNeaHLWBKhLb9dcDr
         CLKczP+qnQqoQsmKhHvDpQGI6JrgWSEWkFzCJ6N38r/s1EiyT7uQ2jgWEOGZPJQLlvjb
         gEkST1y0DEoW7samWJJ1fSLRC5FeGrWIIT+vDXD8RM1jvu3xX4cVty6/eCiDCuEo2oNr
         NV55+/kzoybd3GN0LQ9qyO7Oq8+aVLZdQc8QcXbJrMhrN4NG+2JaudEt+0ZXFpOWyyQE
         ZhkKGZkQwaETIKnWsnEfTZ1HYBHPavANqUQhvnataKw7Aw0BT1K839TMD2eOQ1rmLgoL
         TeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310796; x=1742915596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq4YIdfyvH3D38tBVB9O/pfTAXZmUQ3xOYQLXZJY38E=;
        b=r0JPTDQn+ZISj7aqjbKpJFU8s1qDn02nqdrfZM8H4ny3mz5QsLy/rQLjd/O0dh6sdD
         O2xJRVXbfshlZ9vKZdnxE4LQaHJn/po56t/SrcqVjlT+K4yb61yIipxvADEvkLeaY7pn
         87v2D85J7l5w6oSG/gglnuz7Cb7bouECX4UVgO5e5a1UTcFLvKgVrLe76XWh0jH/nUh5
         P7e2CdXLr3UXcmrqpAWszQ2KAQ1Tns/c/YQ2FcHrtMUWMVJHByHDBPVW9E0ovrqsOdOu
         HtHkRUhTIlmCW+5kGcO49vte4zBM2HrX7FHbUt+mobc7moU/mabji4KWKA/1uxKofAhT
         3lpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBI5yjVzSSYx8J2t0NHIAI3rgs4yGuRI7QH+d1bJjeg2/C/nUVdW/0L9tBq6TvBsx/yHgD0/eEUfJm@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTsgWHDbpiD/FgTOxyrHqPMIkVMMoaw0+SSWI2fOT8n86baVf
	bYvto9mj9iUMLMxjGWaSsVtdLgwHwB0YlB00rEGUe+5GRGHJf5XB6P2ATOWPgYM=
X-Gm-Gg: ASbGnctDBfNXTUIWih35uC3Vrn1d6nSdpD09/nh1L2/aBFSgvweJH1hxlFEgtH5Wz/w
	BLJGzrxNHGBh4pPxeECEkahuXz/lZhYAYIUnEz4/DK1IIMWyVOMte6hbLA1WxTuynRaTeAzhqpi
	OWqnB4gQNQfdUuhFerDxMG9v9lWV7bWU6p/KthGk3ZIZ+tmOT9+thJKmAhHlnJToyFFp6zvzz00
	bDKUbwTlnv5Od5O9XLVkXGpLOwRLZuYRXQESkjQI7yZNAzei5M/STeDF+f9P8P1XXuWnAKOA4jn
	QCDTJnqqLEbzUY+a0U70ci8389ZqrbM4cyWIPykWNSUKTXQJVSt0WZh/FPmOedI3BOvKiRX5Pco
	dGzV40+YElKm5x2ptwehxVb3AHaQ=
X-Google-Smtp-Source: AGHT+IHeMQ4TK7mWZ8ZCPZ0HfjaVy2CNDBY+DoggANGCjpN0TVfqxk3IlMuRg8yeq+gDT6U2kTi9hA==
X-Received: by 2002:a05:620a:470f:b0:7c5:5008:436a with SMTP id af79cd13be357-7c57c73da02mr2385055785a.1.1742310796559;
        Tue, 18 Mar 2025 08:13:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8aecfsm730776785a.100.2025.03.18.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:13:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:13:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>, kernel_team@skhynix.com,
	Joshua Hahn <joshua.hahnjy@gmail.com>, harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com, gregkh@linuxfoundation.org,
	rakie.kim@sk.com, akpm@linux-foundation.org, rafael@kernel.org,
	lenb@kernel.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z9mNiWm1pNIxiu0t@gourry-fedora-PF4VCD3F>
References: <20250318080246.1058-1-yunjeong.mun@sk.com>
 <ed0004ea-c8d6-4ba9-ba40-0c9a97d98db6@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed0004ea-c8d6-4ba9-ba40-0c9a97d98db6@sk.com>

On Tue, Mar 18, 2025 at 08:02:46PM +0900, Honggyu Kim wrote:
> 
> 
> On 3/18/2025 5:02 PM, Yunjeong Mun wrote:
> 
> Some simple corrections here.  host-bridge{0-3} above aren't detected from CEDT.
> The corrected structure is as follows.
> 
> rootport/
> ├── socket0
> │   ├── cross-host-bridge0 -> SRAT && CEDT (interleave on) --> NODE 2
> │   │   ├── host-bridge0
> │   │   │   ├── cxl0 -> CEDT
                          node 4
> │   │   │   └── cxl1-> CEDT
                          node 5
> │   │   └── host-bridge1
> │   │       ├── cxl2 -> CEDT
                          node 6
> │   │       └── cxl3 -> CEDT
                          node 7
> │   └── dram0 -> SRAT ---------------------------------------> NODE 0
> └── socket1
>      ├── cross-host-bridge1 -> SRAT && CEDT (interleave on)---> NODE 3
>      │   ├── host-bridge2
>      │   │   ├── cxl4 -> CEDT
                           node 8
>      │   │   └── cxl5 -> CEDT
                           node 9
>      │   └── host-bridge3
>      │       ├── cxl6 -> CEDT
                           node 10
>      │       └── cxl7 -> CEDT
                           node 11
>      └── dram1 -> SRAT ---------------------------------------> NODE 1
> 

This is correct and expected.

All of these nodes are "possible" depending on how the user decides to
program the CXL decoders and expose memory to the page allocator.

In your /sys/bus/cxl/devices/ you should have something like

  decoder0.0  decoder0.1  decoder0.2   decoder0.3
  decoder0.4  decoder0.5  decoder0.6   decoder0.7
  decoder0.8  decoder0.9

These are the root decoders that should map up directly with each CEDT
CFMWS entry.

2 of them should have interleave settings.

If you were to then program the endpoint and hostbridge decoders with
the matching non-interleave address values from the other CEDT entries,
you could bring each individual device online in its own NUMA node.

Or, you can do what you're doing now, and program the endpoints to map
to the 2 cross-host bridge interleave root decoders.

So your platform is giving you the option of how to online your devices,
and as such it needs to mark nodes as "possible" even if they're unused.

~Gregory

