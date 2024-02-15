Return-Path: <linux-acpi+bounces-3545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E285697C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50DA1C233A2
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901301339A9;
	Thu, 15 Feb 2024 16:25:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E213398E;
	Thu, 15 Feb 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014301; cv=none; b=PsCFY5kd0PZHIyU+aiEgQhZbwCrX3luyOJalnQ4PCBBPKmhrtxlCRU+ZlbJDkvTiufhIH4149NKaCP/JykTeW2UEuda7xBKbdZqsLkZTyU3BncLk5pukMn7zXQWgTT/OYaItJAodk2IU8TIiZ1VlUIE9esezLKkx9azwRU7LTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014301; c=relaxed/simple;
	bh=y72zgNWyZeqvq2fnQytbcWovVw76x4ueb74XOcjn0AY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKshmvYOnD6UIsDxlogHHeG634UXe5P8RYNqRX7qnZBOIFZRN1gLEx6k/uvNxGTGgCR/Mfh5C/gDmGvGDGZfsMcBhrTvB5iZIehArvl8YaVrvhkR5u46xwe2Mov9srZq03GZ770SaQisliXEKMR6cCYxd9w36DY0KqWXarCS7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbL0S1YQ1z67T7Z;
	Fri, 16 Feb 2024 00:21:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D63B21400D4;
	Fri, 16 Feb 2024 00:24:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:24:56 +0000
Date: Thu, 15 Feb 2024 16:24:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 02/12] base/node / ACPI: Enumerate node access class
 for 'struct access_coordinate'
Message-ID: <20240215162455.00002e09@Huawei.com>
In-Reply-To: <20240206222951.1833098-3-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-3-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Both generic node and HMAT handling code have been using magic numbers to
> indicate access classes for 'struct access_coordinate'. Introduce enums to
> enumerate the access0 and access1 classes shared by the two subsystems.
> Update the function parameters and callers as appropriate to utilize the
> new enum.
> 
> Access0 is named to ACCESS_COORDINATE_LOCAL in order to indicate that the
> access class is for 'struct access_coordinate' between a target node and
> the nearest initiator node.
> 
> Access1 is named to ACCESS_COORDINATE_CPU in order to indicate that the
> access class is for 'struct access_coordinate' between a target node and
> the nearest CPU node.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I resisted bikeshedding on names.  These are clear enough for me.

