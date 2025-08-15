Return-Path: <linux-acpi+bounces-15734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A5B280A6
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC338AC2F93
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5267C301031;
	Fri, 15 Aug 2025 13:32:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A641DFE0B;
	Fri, 15 Aug 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264726; cv=none; b=nQLZGQTXqc1gx3s95byqwhQb9Z6BFe6aCTsWO/Wkgm7LxEFeBRKaHSBO4f9mCAneHWWywAtHdHsNQVURURs9OjDqRKKXurDS7SDFYG8kPuT2PDozXNO2J1TUFX+2BZ7JnF9jbuIiHizo+Oaz7bxVba5cysnxxmFj/BeYPcofEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264726; c=relaxed/simple;
	bh=YHnqHSCTTfiByHZ2rBfUXypWaYUuoThI3rL15wOtZa4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ7STDnM8SY6Id10/gXzB25kQpq/NJ3pgrPTbYvZ6S2aYdO0Xny3M2OdnV0YymdGauhYhu7T/2N/l9lX98rBp1jO8ahLKOqoxn3l2ZxpTN954hIiSxXZ9cVHmkrhXQ8mK8qir8zpPz+IFCYtRFlCHK3ZMqbSs6nyh96ESIThnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3NF360n0z6L4t1;
	Fri, 15 Aug 2025 21:27:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B9C91402F4;
	Fri, 15 Aug 2025 21:32:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 15:32:01 +0200
Date: Fri, 15 Aug 2025 14:31:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<marc.herbert@linux.intel.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>
Subject: Re: [PATCH 4/4] acpi/hmat: Remove now unused
 hmat_update_target_coordinates()
Message-ID: <20250815143159.00003f43@huawei.com>
In-Reply-To: <20250814171650.3002930-5-dave.jiang@intel.com>
References: <20250814171650.3002930-1-dave.jiang@intel.com>
	<20250814171650.3002930-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Aug 2025 10:16:50 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Remove deadcode since CXL no longer calls hmat_update_target_coordinates().
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hard to argue with this one ;)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

