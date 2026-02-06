Return-Path: <linux-acpi+bounces-20879-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFPWBAbwhWlvIQQAu9opvQ
	(envelope-from <linux-acpi+bounces-20879-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 14:43:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D4FE59C
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 14:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D42EA3031746
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC993ECBD7;
	Fri,  6 Feb 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKENTsaE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A93AEF4E
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385233; cv=none; b=CUsMM8N/UVkLjK39YYnWHHV76VQGHwhw7uYmrFT4BYvGuIwUUZiBObrZHwyyzT6z6VaNoWTWFVHe+GXySmQmI+6WmRzv2xorBbGiXaSHIMskcU+92Tat5K2tmlkHSaCmRgznaw/4oPqmATXU7Q60c3cU2M4AsAigRC1lvaMdPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385233; c=relaxed/simple;
	bh=w7mAw6niJqOgsf5izqpU2h5e29af7E69XElXtGhGgnY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HhLmspKBZRcUlh7Bc7krpd0YTa25EOzSNL9t3zsP6xeucx31pZbonrl+iVqRB7K05dsoZ9AhdHmXp7sswijDH2hTVKCQ+6IyLdY5MC8qo97vhj/RMhnZ1nBPO1HHBvGS3EntbZSqmpp14e2KlDOEyiD2qoaCDBXEGX0xIpusPtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uKENTsaE; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48069a48629so19401605e9.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2026 05:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385231; x=1770990031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjDO+nWIfeXnTSySIky4d+5vil7cd0azydEMOlee6wY=;
        b=uKENTsaEusq1vqKh8Mbviyha4LeyrpI4H8Ey5D8pAfdhNuzr8yO1TW4rfHb3H5NKuz
         sW/LTHIK8uE4mxL885R4DiplPT0tbUq0kI45MjMxF7AwFEphp6uLpHK2dv5cMIZRqfTF
         /fHxG/kdF8//E/yT4mIwvQ1vmRd2l0WLPr6mebwe8IsoZ9uiP7f3DAULNw9UsRtRKoyC
         WjwFntn3rphXUkqDeOz8LD6LhDLMjoQ8bxBqgHfcAQX+8E6AsWcJNKHxPli2WbGdHE2u
         zDTyWhA17Ira/zVnVnxM9MYor1sSIMCRqnXKIJ3wHVc1D59bzlC3AyQD0WwAIdRhItr/
         LsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385231; x=1770990031;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjDO+nWIfeXnTSySIky4d+5vil7cd0azydEMOlee6wY=;
        b=Q5RhqKq0MnqNIHF2OoEkzglWjDUzeMtBuNH29HzpqiSjMOud9iG9dfWdiUhmFV7H/v
         SRKoW++OMyP+38oH0seM/hz+pY/6LnoptnOfMJDUqMmLkSkp9DMI1NRh+/5NA0cEb12E
         IQStDa+Q5ij2XGbOCpEnuN8PegC1vTL3x8NfqASYWHFLdm7sDLMr5BNEAjVqicHqHN/B
         Zr+cfgy6qGbBLMAlXIqxfbplSvJo9nLlZD5LK+d3smHD7extXrC3ElxJVnPrs6BhhMwL
         II8FLO1/6Y+fEH19V0Z4aRUcjer8xhnIHJgpy4PcPAXL+T36EMNTKAgP8Z8TYm/GvECE
         +gOw==
X-Forwarded-Encrypted: i=1; AJvYcCWtdffZDkP1xg/N5zl1dq2ArC8RJTZS6Ql5qEExzfaUHMuttiirj7CMudRwk5W+7qfefe0LYfyf/ktu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDPondnadNhKn/DspYz2xsASrz8UnCeBbdbdRWqzMJOlMn1NT
	DeZMY8UVjM65z+LE4Vx+IoXzGJ6NwUHHk8jT+pPTWbSgeetDALfcKEpPBEuU2Fp/YZA=
X-Gm-Gg: AZuq6aK9+H3+MYrFyATyUk61J9sPHA7T/QsQO2RlqeHAp06IV62DTx0a7OfXLVBnwtA
	QP7sizH1KFDd37CARDbRO1kzabv41SgfqV2MeI1kWoNrsQQXrbPde4uDzjCQWno6SrbiO7PsjwA
	4lZ+YSdYJd069AjaU58pLWbIUhNcExcxvEbsuhU+AWTV5hRRHr/OZL+4K9gKk/MRUSSzhFkg54h
	yU54HZ6L4oo4UYDmwZqz2mW2y190DaKwwSyqJL/jSK5jUNtzAE38KJ4hA250nZvZXYmNcwR2p1U
	HcuFgZ573vVm1FMBJEs6tk5hFwajYGVmWloXma+11BhB1mjCX5KYvmkqE1BC0rKNzHMBR0POQ+d
	6/B8F3WR5k7ymefXvZveeMype3s7Hq11Iur4WoKQT+5UZ5X4NhLAysMU8UnrlpsLI+ks5+riknG
	XxjbvtLgQFCayaZnZN6jc76lE9G7U=
X-Received: by 2002:a05:600c:4444:b0:471:1717:411 with SMTP id 5b1f17b1804b1-48320216ccemr42200145e9.24.1770385230962;
        Fri, 06 Feb 2026 05:40:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm42270625e9.1.2026.02.06.05.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:40:30 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] ACPI: battery: Adjust event notification routine
Message-ID: <aYXvS1h3Bxf_5sCj@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20879-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 295D4FE59C
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]


Hello Rafael J. Wysocki,

This is a semi-automatic email about new static checker warnings.

Commit 08b54fd57782 ("ACPI: battery: Adjust event notification
routine") from Dec 15, 2025, leads to the following Smatch complaint:

    drivers/acpi/battery.c:1062 acpi_battery_notify()
    warn: variable dereferenced before check 'battery' (see line 1059)

drivers/acpi/battery.c
  1058		struct acpi_battery *battery = data;
  1059		struct acpi_device *device = battery->device;
                                             ^^^^^^^^^^^^^^^
The patch adds a dereference.

  1060		struct power_supply *old;
  1061	
  1062		if (!battery)
                    ^^^^^^^^
Checked too late.

  1063			return;
  1064	

regards,
dan carpenter

