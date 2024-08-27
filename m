Return-Path: <linux-acpi+bounces-7861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E66960443
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063751F2291D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1282315535A;
	Tue, 27 Aug 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dawn3zG0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3A157468;
	Tue, 27 Aug 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746853; cv=none; b=uWHzI8mdQuDcxfz4s8+2ztTxWjmcyqkUSwJS3epGSJC5BwtjUnDbyvUHSKEYRwvfdcUqsPMvUDAHLxWWga+u/vtv12CdKdYvuFsP2j2+DhLChC3zVv35erOvI19WDNDUu5ArRLFGVw1bUvDBss0wjjeYnrwNYOocerjPzgTvUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746853; c=relaxed/simple;
	bh=s5DnIhW2HlQw8lb50wgDoawNR40ocw5I4M1PiF1zyFQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ut4iz1HEEiLAGr1DA0F8iW8XqrAdA/aSljugGl4c94ndW3erGs3//c4UYctpfXJ6crNfWMT+RMvZHmstZeBxeZ62n+8hNb9uqkzoaaUQTTx9otTeT2Hm5ioQngy2Ul4qsLK4o0WD0NmmT8+/yGjlN6XAk4XgfCS3J9IbPEw9ffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dawn3zG0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724746853; x=1756282853;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s5DnIhW2HlQw8lb50wgDoawNR40ocw5I4M1PiF1zyFQ=;
  b=Dawn3zG0ZkYoBzWrp0ny6A+5LLVWegXUYL2azQdHMqSO86fbzEpjl52/
   YDBD8lnNksXDHezZuWbl3ITf7qHnFjSJgfxWfQVO1tghtDp/96ZzYqY/f
   XyDj7yV+qgNIgr7LoY9FqXTUdzn/KIkTCY0wYjU0Bmrj68M4IlfsPI5sN
   CAQfaeGamM0oJ8cd89ZeSbKGBPTOaOR0vXkrSKymCUh1oC0wDIUTyhnnt
   rxPLlIFhwYDpvHEvpdGRI65Cdp7nNkAVykgeH11awq2OqnHKUbZgOWMD9
   hXcnh3wIP/tf71t20SKZMcdnJKhPy+FyAHwOaQn/zh8gmKkymxoNyaDAQ
   w==;
X-CSE-ConnectionGUID: lR6T1VhVTkqiNNHZYQwNtA==
X-CSE-MsgGUID: NTfviuiaRXWGYaXgPnSXBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23076579"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23076579"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:20:52 -0700
X-CSE-ConnectionGUID: Ve09SytXT6iB8i6EVrOwRA==
X-CSE-MsgGUID: +urC9lAiTXu2RnLEMr6uZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62757754"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:20:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 11:20:42 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com, luke@ljones.dev, 
    matan@svgalib.org, coproscefalo@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
In-Reply-To: <20240822173810.11090-3-W_Armin@gmx.de>
Message-ID: <e791f8ed-f6af-d433-5c9b-a68fc9598dcc@linux.intel.com>
References: <20240822173810.11090-1-W_Armin@gmx.de> <20240822173810.11090-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Aug 2024, Armin Wolf wrote:

> The BIOS can choose to return no event data in response to a
> WMI event, so the ACPI object passed to the WMI notify handler
> can be NULL.
> 
> Check for such a situation and ignore the event in such a case.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/hp-wmi-sensors.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index 6892518d537c..d6bdad26feb1 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1628,6 +1628,9 @@ static void hp_wmi_notify(union acpi_object *wobj, void *context)
>  	 * HPBIOS_BIOSEvent instance.
>  	 */
> 
> +	if (!wobj)
> +		return;
> +

I'm left to wonder why is this patch is not placed first? Can't this 
happen regardless who gets the wobj? And in that case, should this have
a Fixes tag?

-- 
 i.


