Return-Path: <linux-acpi+bounces-3687-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2EF85A264
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Feb 2024 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7372848B1
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Feb 2024 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB972D051;
	Mon, 19 Feb 2024 11:47:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4462CCB4;
	Mon, 19 Feb 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343252; cv=none; b=NWdAAmXmq/sRRLuLsjUgJjbY5AX3RPi6/QZuZeLsOGEY4R9N+RYG+/brIQNkBdvrkEgeHcLEIioNrgOdk7oYYqJDuVbtP2oFxsE0OFXIMKWpzUmhatmEhbEQ/vBdpwAulnSOSOU/5CCJSIvHfRJpTOYNmi/F7Cd9CZyl3VbjNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343252; c=relaxed/simple;
	bh=qQWNAa3rHjdaAl5JSrWrPWVk6WSw4xgV59on5h3QRjU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB30V40WphevwyLB5mF8By7O84biB9C3RbiiFe1VZ9270h1iXh4NgAM/mafLhlIs2NLDxtIeBfO3vsCPCTjmSk28euDC1FwcePpVxq3s6NatZb7UwZJ9lzlcP0yG/8RZiA9vxjsBnsc0EKzeFjubrMJpJ73288eTWgkB8IXDMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdgfh0KTRz6K9B6;
	Mon, 19 Feb 2024 19:43:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 26EDA140D1D;
	Mon, 19 Feb 2024 19:47:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:47:28 +0000
Date: Mon, 19 Feb 2024 11:47:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi/ghes: Remove CXL CPER notifications
Message-ID: <20240219114721.0000420b@Huawei.com>
In-Reply-To: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
References: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 17 Feb 2024 12:29:38 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Initial tests with the CXL CPER implementation identified that error
> reports were being duplicated in the log and the trace event [1].  Then
> it was discovered that the notification handler took sleeping locks
> while the GHES event handling runs in spin_lock_irqsave() context [2]
> 
> Given multiple bugs to fix and how late it is in the development cycle,
> remove the CXL hookup for now and try again during the next merge
> window.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: http://lore.kernel.org/r/20240108165855.00002f5a@Huawei.com [1]
> Closes: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
I'm fine with this.  Updated text in thread is fine as well.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



