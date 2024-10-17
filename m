Return-Path: <linux-acpi+bounces-8852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1459A2A3E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A3C2832A3
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9C1F6660;
	Thu, 17 Oct 2024 16:59:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A661DF744;
	Thu, 17 Oct 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184393; cv=none; b=LG7LDeg7n2wZgwrPl+dIa+FPov4cjpWomF5QmGsEP8JpwOfy0vzPECU2IkiTquK/BhJgTFraYNGtnlQdae06b+KYgCZdMq+5DQ1q1ikCfIh1zz3YOcExkOJU61X1CT6EgGtAgkcX2gvCeVL+Rwx7IkLWfDCsUmPU3e7lmxQPCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184393; c=relaxed/simple;
	bh=ARY6QB40hS8SjbiQQrQF8tLLS7fueNq5q3sRfcztBfo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljL9GoL3GP6PueP1XcYfliTk24Q17bmB9ylg6eTxMVYHxbQGHqCBZCXhpjXcWuDAkxRmpoT6wsYCTMzli+ltvb8/khAqvuKoXMUiw6lmqXB54f1BSuLqrtAhbFX5PEmcZcI7ITYpdsEbc/aeIGda77h3Y3rpU1Zh67PA+5qTWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTvCr6hG1z6K6kS;
	Fri, 18 Oct 2024 00:58:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 871F7140B67;
	Fri, 18 Oct 2024 00:59:45 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:59:44 +0200
Date: Thu, 17 Oct 2024 17:59:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Jiang, Dave" <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "Schofield, Alison"
	<alison.schofield@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide
 extended linear cache translation
Message-ID: <20241017175942.000072b4@Huawei.com>
In-Reply-To: <SJ1PR11MB6083FB95773B782EA494C985FC472@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-5-dave.jiang@intel.com>
	<20241017173326.0000191a@Huawei.com>
	<SJ1PR11MB6083FB95773B782EA494C985FC472@SJ1PR11MB6083.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 16:46:35 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > What does the I/O hole correspond to in the system?  
> 
> PCIe mmio mapped space. 32-bit devices must have addresses below 4G
> so X86 systems have a physical memory map that looks like:
> 
> 0 - 2G: RAM
> 2G-4G: MMIO
> 4G-end of memory: RAM
> end of memory-infinity: 64-bit MMIO
> 
> Depending on how much MMIO there is different systems put the
> dividing line at other addresses than 2G.

Ah, thanks. So this weird cache setup might be not quite linear
module N aliases as described in the ACPI spec (System vs host
physical addresses I guess).

Had wrong mental model :(

Ouch.


> 
> -Tony
> 


