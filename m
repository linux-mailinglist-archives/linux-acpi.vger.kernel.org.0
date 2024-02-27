Return-Path: <linux-acpi+bounces-3984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B9869D91
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 18:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B771F212F2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3F4CB4B;
	Tue, 27 Feb 2024 17:23:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9E4D9E8;
	Tue, 27 Feb 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054634; cv=none; b=lNeRM7SFq+B8gQSfyqTMkEGl8FG1WWK45Alo+ULeZ/irYwlzARXgTkZG+obef66YfTJ+F+RfBOwy21lDUD/WQpxDCh+d3HqJxPZ+ANxVzLYQ5i9ee3th+kvER3FI8Y+b+71tc9/aY5JS2lhRAASRd4JjzyYg3qHsymKgiUDgxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054634; c=relaxed/simple;
	bh=gO4uBFAULdnWaN7HfD9cgRwShfL4A3mMdlnoDde3QSI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tz++2eLuhWzMj+yeroe4X/vuKl06Fz216Vp0QPUbd8KxLOcIS35maolGTHEPRaRVVAuaXeFSRTUfi//XY8HzpaxRDwVXHbMRtxMiV4WCquC8y50AaMG6FSRW2i1UB7awHy7WYGcbIMqWtMyl4FaowzAC0ISkUXK32Ml1FVZmOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tkkjq6Fzqz6J9p2;
	Wed, 28 Feb 2024 01:19:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E4F0D140F26;
	Wed, 28 Feb 2024 01:23:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:23:48 +0000
Date: Tue, 27 Feb 2024 17:23:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 03/12] ACPI: HMAT: Introduce 2 levels of generic port
 access class
Message-ID: <20240227172347.000076bb@Huawei.com>
In-Reply-To: <20240220231402.3156281-4-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
	<20240220231402.3156281-4-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Feb 2024 16:12:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In order to compute access0 and access1 classes for CXL memory, 2 levels
> of generic port information must be stored. Access0 will indicate the
> generic port access coordinates to the closest initiator and access1
> will indicate the generic port access coordinates to the cloest CPU.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



