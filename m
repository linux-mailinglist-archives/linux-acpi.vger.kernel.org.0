Return-Path: <linux-acpi+bounces-12070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106CA5BCEE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 10:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9573A6283
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F322DFA5;
	Tue, 11 Mar 2025 09:55:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1671E2606;
	Tue, 11 Mar 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686941; cv=none; b=W+gkS2WPT6/YtCKb+NGF36nddqog5YrIJblZICQaLzDdY2uXqEk6e3S0uvEZhWgrNXETuVcdkKLrJl/E48Hyx8wrpHrjcugTmD4SY7yrnUFpcw5yks+cA6iSxdZ7I67WPR9DV/cRG+Z7G9wnKVPhFfL4FMWngsgsUevCYBGQPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686941; c=relaxed/simple;
	bh=RkKAa+RUaKvqUs0owPDHs5Qz1XboaWKcyIfZL0wryxU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieyviRh4TB1+3iO6p/VCQZTyR9nvTcEnbD2h2RJkcLUf82HqWXeTmA5ZVd/KA2+gHjphCriIbN29+OCKUEMdghPkjVTlcIz7X0BAmXZyVl1ha2zwRcye9ZnBVaga1RG/i+jNLM4VDZwPRUhfTBvwQAjZFtjslpVOyH9fahEi/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBptS49C4z6J69B;
	Tue, 11 Mar 2025 17:51:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C579140CB9;
	Tue, 11 Mar 2025 17:55:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 10:55:36 +0100
Date: Tue, 11 Mar 2025 09:55:35 +0000
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
Subject: Re: [PATCH v1 4/4] usb: typec: tcpm: Use
 fwnode_get_child_node_count()
Message-ID: <20250311095535.00004754@huawei.com>
In-Reply-To: <20250310150835.3139322-5-andriy.shevchenko@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
	<20250310150835.3139322-5-andriy.shevchenko@linux.intel.com>
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

On Mon, 10 Mar 2025 16:54:54 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since fwnode_get_child_node_count() was split from its device property
> counterpart, we may utilise it in the driver and drop custom implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Seems like a nice little series to me!

Jonathan

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9c455f073233..8ca2e26752fb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7166,7 +7166,7 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
>  
>  static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
>  {
> -	struct fwnode_handle *capabilities, *child, *caps = NULL;
> +	struct fwnode_handle *capabilities, *caps = NULL;
>  	unsigned int nr_src_pdo, nr_snk_pdo;
>  	const char *opmode_str;
>  	u32 *src_pdo, *snk_pdo;
> @@ -7232,9 +7232,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode
>  	if (!capabilities) {
>  		port->pd_count = 1;
>  	} else {
> -		fwnode_for_each_child_node(capabilities, child)
> -			port->pd_count++;
> -
> +		port->pd_count = fwnode_get_child_node_count(capabilities);
>  		if (!port->pd_count) {
>  			ret = -ENODATA;
>  			goto put_capabilities;


