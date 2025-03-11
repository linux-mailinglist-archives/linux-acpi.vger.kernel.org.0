Return-Path: <linux-acpi+bounces-12068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0EA5BCD8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E16161A37
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA25234969;
	Tue, 11 Mar 2025 09:53:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9922DFAD;
	Tue, 11 Mar 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686786; cv=none; b=IVpZWYPGlOiZOYYQerEp00HPJ/TruTxPgUujehP8uQaSvh1M6OJ3dVAxd+V6KgNnD8E//SijrSwYmVRM+24CUVtzaNOH63EsYEkoCy3FeuawznAumvW0D1kqt8/QKXqocT38+T289JagYEPcwwuyjPb9Ebz4e5bmTQYzhfFgGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686786; c=relaxed/simple;
	bh=XlRIUEmg7ePrZSczJQNPWZA2VCpkNf/KZaqoOHLetlY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRlrmPguR51urlK9HQQzrH7RlHYyS7Qp5s625voHJSRNE7FG4C4mWPetMT7zrEmAsx2rHwmy3erj84IZB+4gQLB6/+T/TirUEuPEJ4/ozCDAJH0nasfym0lEUrLmMbPujAmnb53TXBZSpNTfHqRTjVxxI112sGjzj2qKHz9OPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBpqT4TzMz6J6Bc;
	Tue, 11 Mar 2025 17:48:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 959FD1404FC;
	Tue, 11 Mar 2025 17:53:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 10:53:01 +0100
Date: Tue, 11 Mar 2025 09:52:59 +0000
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
Subject: Re: [PATCH v1 2/4] leds: pwm-multicolor: Use
 fwnode_get_child_node_count()
Message-ID: <20250311095259.000068d2@huawei.com>
In-Reply-To: <20250310150835.3139322-3-andriy.shevchenko@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
	<20250310150835.3139322-3-andriy.shevchenko@linux.intel.com>
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

On Mon, 10 Mar 2025 16:54:52 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since fwnode_get_child_node_count() was split from its device property
> counterpart, we may utilise it in the driver and drop custom implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

