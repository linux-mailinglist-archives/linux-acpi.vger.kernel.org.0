Return-Path: <linux-acpi+bounces-10496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2184A08128
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 21:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7021C188B99F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217C1FA8FF;
	Thu,  9 Jan 2025 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="SqAegk2v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C116B677;
	Thu,  9 Jan 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736453418; cv=none; b=bhZk7c5KnHW1ucOqrYbSLf8VCGyZuriHsqh04VZ9/6V5RcOZcmVQqcbm2WGEvYTnFl5LVXH0zt/ptzPYjEVf+VsKuBEEsl0JxhCYNLHxa4fHx1/3nFXkDNJwcANAqNQc7rlbA5nnM7R389mm7uwV75ZIwdVs/EzeJqXCDUiYdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736453418; c=relaxed/simple;
	bh=xyOkte17MlxkYhc4vhOvkDvtEQ3VCGHyGxH+gSnDL+o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H/9AFfCqVycu4J1Jxvmypp+IM713Q+lN5CfX1e0fTkQAWqg6lv6OcLNSbksdhXZq23IzwWxS39UiW4izj5g3jAgoDNLo4+My9vwVJjHVzkY48DY985nPexxXdsnScQZe6eotpoCcSiwkbFTQD1zP0OZnG+aBhZ6HGGa3Vj+vCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=SqAegk2v; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id B188C2FC007B;
	Thu,  9 Jan 2025 21:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736453413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ee+m8qcI6JVFgcX72ldTrJwJDa+YrjxcODKh1jq/blM=;
	b=SqAegk2vTYSBrCduZ5CZ1NzcCZvLz6X4LU83Z9B8sKb3ir1Fx0JxwwuukM5KQBOHBOETkO
	tYZmIIXdM2okbdBIKOb8SqQF+C28uAu/gDtpwwjkDtjR3L2UBUH/AhZ5LsLcb/g9DHPc9U
	ww5d+Fdqo4lNdieFtsAS8C/JdXKS3Nc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <2d24e844-242b-4c1e-9e43-f0bec1a98ed5@tuxedocomputers.com>
Date: Thu, 9 Jan 2025 21:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thermal driver with safeguards
From: Werner Sembach <wse@tuxedocomputers.com>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, Hans de Goede <hdegoede@redhat.com>,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

Am 02.12.24 um 15:52 schrieb Werner Sembach:
> Hi,
>
> given a pair of a temperature sensor and a fan, I want to implement a driver. 
> that allows userspace to directly control the fan if it wants to. But have a 
> minimum fan speed when certain high temperatures are reached to avoid crashes 
> or hardware damage.
>
> e.g.
>
> - temperature of target die is 80°C -> fan speed must be at least 30%
>
> - temperature of target die is 90°C -> fan speed must be at least 40%
>
> - temperature of target die is 105°C -> fan speed must be 100%
>
> - temperature of target die is 110°C -> device shuts off to protect the hardware
>
> Would the thermal subsystem be the right place for this to implement this 
> protection in driver?
>
> It already has functions around periodic temperature polling and trip points.
>
> Kind regards,
>
> Werner Sembach
>
Sorry for bumping, just wanted to make sure that it doesn't get lost because of 
the holidays, as the question is still relevant for me for rewriting and 
upstreaming tuxedo-drivers.

Best regards,

Werner


