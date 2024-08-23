Return-Path: <linux-acpi+bounces-7794-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C02795C515
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 07:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592D72826BE
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9210762EB;
	Fri, 23 Aug 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b="m+osVJQg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11674424
	for <linux-acpi@vger.kernel.org>; Fri, 23 Aug 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.61.254.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392646; cv=none; b=GY090VdlWQ8ldtTLjo7rvX69NvbbI0uzu1fDTeSk3o7Ih4dFQ9OIyclNRpXcr66u1I1cNqBATClj9Tzvi0gNJk217nX5ukiQH+VYpTK3Y0L8gItTqs4D2PLIvq/8S7H/rrBEPJE4WOecgeMcDJc/v+ECoe10tRU8gEP7e6vTXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392646; c=relaxed/simple;
	bh=BZJwmLYYUt0OprlBbHQaq4XEuX1Yu/mMxNf58jHFWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8BpqYso65EK+ZOgKsPhEmJjwLFQq4EiHMsK16Ia/8+u8nMZgvFSGvE7Yr7KzcuoDpHQ+iF0brTYWjSGVLJMjQ0YxehLNBKNSTiYkJOkFn6iztmDfHwoMB8aj7T+sUq38KEBqUCtwlhvYCaBH8Vm+YkBg2GilgQC3vgu3649Usk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech; spf=pass smtp.mailfrom=equiv.tech; dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b=m+osVJQg; arc=none smtp.client-ip=198.61.254.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=equiv.tech
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt; s=mx; t=1724392644; x=1724399844;
 h=In-Reply-To: Content-Type: MIME-Version: References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date: Sender: Sender;
 bh=u+VhrC22RZGtxJLHBK+uwUVXwszI5ugWNatDD2VcTAQ=;
 b=m+osVJQgeWYiDEOsu6CcMe/CMkplzZl40QPX6hThpjmfYeFJrB6P67F9D+X5BZCoveoUkNFPpIYBtK5epbVgVAE7S1Flz5++bqxnaWIwbs20nShgzA+ZnlhSKlufIR7K/QXIfe7mwBz3yWcDmU0snEWgwnGmsoUU2bJ+QYdkkbq9u6IkE9AFbiGuV6Jum9A5KkVanrVoYXBHM6R4OQLNHlwKdeyzl1QNt+aeDBCmlgN4zIHv4zBtKhUFfslhOv7bYSWZenBBbTUdp9lBtMW2Q/jmE5KpTAOUedwbGSNePpTffVqa7f4MNfJ55qlwJc6wyx4IOCs/J2LSdZiKCKAlXw==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyJkM2MxMiIsImxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnIiwiOTNkNWFiIl0=
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by f97076a2080f with SMTP id
 66c824c4c8b26bc9edd95b27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Aug 2024 05:57:24 GMT
Sender: james@equiv.tech
Date: Thu, 22 Aug 2024 22:57:23 -0700
From: James Seo <james@equiv.tech>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, corentin.chary@gmail.com, luke@ljones.dev,
	matan@svgalib.org, coproscefalo@gmail.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
Message-ID: <Zsgkw1kHz9TJx27g@equiv.tech>
References: <20240822173810.11090-1-W_Armin@gmx.de>
 <20240822173810.11090-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822173810.11090-3-W_Armin@gmx.de>

On Thu, Aug 22, 2024 at 07:38:07PM +0200, Armin Wolf wrote:
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
>  	mutex_lock(&state->lock);
> 
>  	err = populate_event_from_wobj(dev, &event, wobj);
> --
> 2.39.2
> 

Reviewed-by: James Seo <james@equiv.tech>

That also goes for the portion of the previous patch in
this series dealing exclusively with hp-wmi-sensors.

