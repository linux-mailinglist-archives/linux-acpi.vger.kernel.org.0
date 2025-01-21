Return-Path: <linux-acpi+bounces-10774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB0A180A2
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C17E7A15A9
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31401F192F;
	Tue, 21 Jan 2025 15:02:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2D23A9;
	Tue, 21 Jan 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471765; cv=none; b=p8QiiwPLv0KsX/RXJorNXKMHbPxkhlfJFcRMjwJVlkSsuTRabsrmqWHLRCiX9+y4w2HF5KLX3xfyTvteHflO1Ik310aL7TRSzruvWdVS2KkzLin626ZWjzgim3ir97bohCquKjCbSC0l9nlcGQ/SM04dUTzob6G3Ckw0/6DUcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471765; c=relaxed/simple;
	bh=GRaEl2vm9zR3T1dtZlUaFgjHjFFASMc5oO7SD6t2tzA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxmXfuxQIKQdm9FkxXLwhRTBnr4oLMUHqg9iL/Qj9LQr0sM6WxLh/JCkHfgtJ+oofaeawG+OZKe9ezx8blr98HellSbvWD6WZ51lxJvyMDb7FjyXSHIJOsJT9dRkc3hws+I55MhtirYn44EERM1XUF95XAKtb9Xogi5Q0ZsUAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ycr6D4thWz6K5nd;
	Tue, 21 Jan 2025 23:02:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F10FE140367;
	Tue, 21 Jan 2025 23:02:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 16:02:41 +0100
Date: Tue, 21 Jan 2025 15:02:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v3 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <20250121150240.00000511@huawei.com>
In-Reply-To: <20250117173054.4147877-4-dave.jiang@intel.com>
References: <20250117173054.4147877-1-dave.jiang@intel.com>
	<20250117173054.4147877-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 17 Jan 2025 10:28:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

