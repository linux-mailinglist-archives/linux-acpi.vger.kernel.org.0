Return-Path: <linux-acpi+bounces-17885-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ACABEB0CA
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E0E3B3C84
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231D304972;
	Fri, 17 Oct 2025 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKUDRAeX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F1305E0D
	for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721352; cv=none; b=koedIxH8nAoDw4r7PfdWpXkEMIlWnOJWzxvTJwvsztXcNgJesWgzeUmElY+l1sQsj82e4I9dEmdCdoNLTxQzJj0LTCDg0bSalNrArrH6R+JUqC3veuf9BeBNnbqUDjG2JxK5/uujlEkwCFakaDdSy92I8uRvoSpfNLpmq3/cZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721352; c=relaxed/simple;
	bh=NWKUkYBNpKDj7J0oxiUsokGoypP3HODuHaVWl982Kik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PuNrw0vUGHcl4fvM7IUteIAxdOn6fAKV3bYtXL6EAAg7SuCgu5VTMuQ3OAMX21VEiv2XZs69Ta5iPF95qp3xumq2x3WBqCj9+f+SeZfZkocX8InEcKb9UOf8aJWAoGCPWq4aqnIGKGv6DTXFmxVdL/sYeuITF/WSNJawBXnNM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKUDRAeX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760721350; x=1792257350;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NWKUkYBNpKDj7J0oxiUsokGoypP3HODuHaVWl982Kik=;
  b=VKUDRAeXj3Jh5kea1/n2eOQX24cAH/ikl9fiEZxzEvMXoL98bVY3jcea
   mMP7gY0U30dQXKgwwP/Gh8Fd5wx8C7LiJu2LhK54dJNiD32hlDf8aGeun
   EY7ALxCFtuovByJtZtdjholkMfM56+uF04KXBzLXNqYjGn12oKO+5+h+p
   FNtlsMfs4bhVaDexH9aLgBLeT0T936DehvmQFGCAiWShRMcgX4qO3/bPZ
   WgIV6YjRYiMm1TRA6ie6R2+qOr5xgsa8oj8J0Z+ch3zYM6cRopo6NaJi/
   3jGkA/7ML7iI5cEPWerKs8P6nwCpluZVLyyfcMMgzlykfTpH/hxyycYqk
   w==;
X-CSE-ConnectionGUID: tdjiZzpZRSulc0sYP0aaJw==
X-CSE-MsgGUID: F7QcKAp7TQWZEDsJHDLv/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="88408622"
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="88408622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:15:49 -0700
X-CSE-ConnectionGUID: hKqlG5FhTVinzw/bO+lhHw==
X-CSE-MsgGUID: Mq5DYEVYQVanwzXerXmwcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="213756154"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:15:50 -0700
Message-ID: <2bc7f4793b295ba0c2abf72ae93ebfa7c6860c8d.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI / DPTF: Fix typo in
 current_discharge_capability_ma attribute name
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rafael@kernel.org, 
	rui.zhang@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Date: Fri, 17 Oct 2025 10:15:49 -0700
In-Reply-To: <20251006043149.967725-1-kaushlendra.kumar@intel.com>
References: <20251006043149.967725-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 10:01 +0530, Kaushlendra Kumar wrote:
> Fix typo "capbility" to "capability" in
> current_discharge_capability_ma
> sysfs attribute name across all references. This corrects the
> spelling
> in the DPTF_POWER_SHOW macro, DEVICE_ATTR_RO declaration, and
> attribute
> array entry for consistent naming.
>=20
This is unfortunate, but ABI change.

Thanks,
Srinivas

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> =C2=A0drivers/acpi/dptf/dptf_power.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/dptf/dptf_power.c
> b/drivers/acpi/dptf/dptf_power.c
> index 776914f31b9e..a3b25d9065c2 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -48,7 +48,7 @@ DPTF_POWER_SHOW(rest_of_platform_power_mw, PROP)
> =C2=A0DPTF_POWER_SHOW(max_steady_state_power_mw, PBSS)
> =C2=A0DPTF_POWER_SHOW(high_freq_impedance_mohm, RBHF)
> =C2=A0DPTF_POWER_SHOW(no_load_voltage_mv, VBNL)
> -DPTF_POWER_SHOW(current_discharge_capbility_ma, CMPP);
> +DPTF_POWER_SHOW(current_discharge_capability_ma, CMPP);
> =C2=A0
> =C2=A0static DEVICE_ATTR_RO(max_platform_power_mw);
> =C2=A0static DEVICE_ATTR_RO(platform_power_source);
> @@ -59,7 +59,7 @@ static DEVICE_ATTR_RO(rest_of_platform_power_mw);
> =C2=A0static DEVICE_ATTR_RO(max_steady_state_power_mw);
> =C2=A0static DEVICE_ATTR_RO(high_freq_impedance_mohm);
> =C2=A0static DEVICE_ATTR_RO(no_load_voltage_mv);
> -static DEVICE_ATTR_RO(current_discharge_capbility_ma);
> +static DEVICE_ATTR_RO(current_discharge_capability_ma);
> =C2=A0
> =C2=A0static ssize_t prochot_confirm_store(struct device *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
> @@ -102,7 +102,7 @@ static struct attribute *dptf_battery_attrs[] =3D {
> =C2=A0	&dev_attr_max_steady_state_power_mw.attr,
> =C2=A0	&dev_attr_high_freq_impedance_mohm.attr,
> =C2=A0	&dev_attr_no_load_voltage_mv.attr,
> -	&dev_attr_current_discharge_capbility_ma.attr,
> +	&dev_attr_current_discharge_capability_ma.attr,
> =C2=A0	NULL
> =C2=A0};
> =C2=A0

