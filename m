Return-Path: <linux-acpi+bounces-12066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6516A5BCBE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B64216C717
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059722B5B1;
	Tue, 11 Mar 2025 09:51:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3D1DE4CC;
	Tue, 11 Mar 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686717; cv=none; b=AcXRd1Qi9cM8YVccLj7JqT7o893wLn56awExm40HUXrz+2fmRTk5kv8yQ0XNuOlOYbSAaCNzLzt6sWDaBPX07G5vr4gE31WWIW8mq4Dm8eIOONoJGRyKXnMHyKuCX0re05z2+qdMpxKQ0GXPmjWn9Dg9A6CKKbtGJVN2NcFVInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686717; c=relaxed/simple;
	bh=FZOwwqMOGRWFzyGwokqCGKYRggXpUAX9t7EZTFHd7zo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+pis0hqs7Vl965gY7bXKR1cCdTrAIRyL04xXSZJzTbjbeAjOxAqAWq6tBZxyNHkpnSo8Tww2HQnUiV51qw2zJnwPFuzqGCBY3aLlGxkzT5Opl3X2CeHwYUVTtMYKbb9a5Q9V9A5Y2ZZjDpEIrN92X/9YORfc+O+OuZfbkHl53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBpqf38Kkz6H8WB;
	Tue, 11 Mar 2025 17:48:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 087C7140CF4;
	Tue, 11 Mar 2025 17:51:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 10:51:52 +0100
Date: Tue, 11 Mar 2025 09:51:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rob Herring (Arm)"
	<robh@kernel.org>, Markus Elfring <elfring@users.sourceforge.net>, "Jakob
 Riepler" <jakob+lkml@paranoidlabs.org>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>, "Sakari
 Ailus" <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Lee Jones
	<lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Matti Vaittinen
	<mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 1/4] device property: Split
 fwnode_get_child_node_count()
Message-ID: <20250311095150.00001ce0@huawei.com>
In-Reply-To: <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
	<20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 10 Mar 2025 16:54:51 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The new helper is introduced to allow counting the child firmware nodes
> of their parent without requiring a device to be passed. This also makes
> the fwnode and device property API more symmetrical with the rest.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

