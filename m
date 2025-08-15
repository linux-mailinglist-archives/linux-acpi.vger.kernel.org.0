Return-Path: <linux-acpi+bounces-15732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA886B2809D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36028A06214
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB030276F;
	Fri, 15 Aug 2025 13:29:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E6302767;
	Fri, 15 Aug 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264540; cv=none; b=UCu0Bc9iDgtxu1qzd6PxXMlVm5peez0RKiH1jMDUIYyZPWjfz9vUWBhyGsRA4KGzVI9fLTsoemVMZvEPgTb6SsT1CVYqB0ZlK78ZxggAzAyML98h4pkCAVSzUQ2/XPJUzdAUUymDtjkesar3Hw5AepomWgNYFtlmuWgn+wwctyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264540; c=relaxed/simple;
	bh=p5BwAcFFwgv9zq2Qmq8O+Rylf2SEoz3ZFkUwZoKc6m4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoUug/48F0CHE/YtbZ4oLB9Yqu+3ulatDh8GT2OJ0Sh02uBkazyRB4+ErS/Gi2jih/QWwsjWrsMbJWEsD1EV1JcLjzGxz+M3/R7cn+St/q7BGSPL7KG7MAr/SjSrA3/2OUWDgTivp09Mm0fbXohkc07d2jLYT67bWaQ8AfmXgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3NCz0NVlz6L5P1;
	Fri, 15 Aug 2025 21:26:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 504891400F4;
	Fri, 15 Aug 2025 21:28:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 15:28:53 +0200
Date: Fri, 15 Aug 2025 14:28:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<marc.herbert@linux.intel.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>
Subject: Re: [PATCH 2/4] drivers/base/node: Add a helper function
 node_update_perf_attrs()
Message-ID: <20250815142852.00000bec@huawei.com>
In-Reply-To: <20250814171650.3002930-3-dave.jiang@intel.com>
References: <20250814171650.3002930-1-dave.jiang@intel.com>
	<20250814171650.3002930-3-dave.jiang@intel.com>
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

On Thu, 14 Aug 2025 10:16:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper function node_update_perf_attrs() to allow update of node access
> coordinates computed by an external agent such as CXL. The helper allows
> updating of coordinates after the attribute being created by HMAT.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


