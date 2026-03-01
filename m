Return-Path: <linux-acpi+bounces-21291-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLUnKJzRpGnJsQUAu9opvQ
	(envelope-from <linux-acpi+bounces-21291-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 00:54:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C81D1FB8
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 00:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D592D300E276
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 23:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30813002DC;
	Sun,  1 Mar 2026 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESVA69Dx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD81F4C8E
	for <linux-acpi@vger.kernel.org>; Sun,  1 Mar 2026 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772409241; cv=none; b=X2ngNF3EHTBoSlR+rYO3gQy6hvR+Uc7WTlQCtkVuHf0Q2d23Pai2ksROqhhz1lwKp2Jav2Tpc0gZcwrJmYaNCWP26+vAmJLgzdoeff6MtzFHOLSb3TKsuQRSnMs0Lgz8Qw2ULXSglYEdvcNuLf2EFHSbkwfAxzB2iM7pDYyB408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772409241; c=relaxed/simple;
	bh=a2iFebN5L7jFdqFDZSM7KmflT7Sl3ML/3xj2QmAgu+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzB+zBuXUOdeOIERUkHpGBtwJvpKiuvG4hQxYMUL0mJFuE9uK+OHd1adOvXKFCUoTdAkmasODzgCGeWTOyAwYtpDxq0nJE0y3LnehuK1HTOVTAEIw/uN1Hy4W9nTSDYL26f8wYbV/mF6MjQSSULBwNQ7mAI7afShqdQtAuoi7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESVA69Dx; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdc47747e2so2866040eec.0
        for <linux-acpi@vger.kernel.org>; Sun, 01 Mar 2026 15:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772409240; x=1773014040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEWH317fbKM8FxNjJAXj9I7cNExo+KpXcRObD8UxbDQ=;
        b=ESVA69DxKtrburl66QmLaNqE4RwH8HU9kRyukHiFokjTfR0Eir3MCP6lF7Nj7GMxsb
         Ws7QmSNlLwIrMcMEgBd5sS5q6Ng8nXID7Jtmaf19NewQ0ELEUwahbfQd1k2Mn2NuQlDU
         mdPdoZjtHK5TDAzRmKYjYHGb7NhtUhpuBUmKJWBMtLm4EV/s9Y/mY8zGUKox/2gtAEQT
         WFi9JO+MVmex8jIBe+A44/8ptGF+pIz4+EQBKfKqd91H8hjZS90Z5Wf8gHnwJnTo1y83
         S6CLmTPNUJjYjNfxa3KzVgVEffmvARKUPHjlyQr4VQF3xdz0HA1crZ0mkmWotWiI8QDv
         xQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772409240; x=1773014040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JEWH317fbKM8FxNjJAXj9I7cNExo+KpXcRObD8UxbDQ=;
        b=i4XpVI/xIjEaS3nPB7WwHowo+HN//5hTUA5WFUUn8WoGhgZaZWO3QpF55aSefIoCXC
         4kfvmNbjzLNnJ65PcAC55iElcfEMhqLbpH3JlNKlZU1cNdOkjaSUWM4eB7QdEgfJsC5D
         LkAhwRgOqcyS+52VzofBvdr5qhAN0XoataoDydRUw5sHKcwIvJROHHxYI/GtoROOJf7v
         p8GGXWxDZUDY/5f9VrW5BwNYkFeGV4QJhiH8/VYdxUIQiJ7+Q0VAY2KsLdHBuMDzZbdQ
         x4l2Y6GsDKiuULzWAhzsWRInfgfJOrDPf+vDqKdKm7FJGjLFB5ytQuUcW1Tximo7QECO
         VLQw==
X-Forwarded-Encrypted: i=1; AJvYcCVGb/IuZJEAmFhtT1IOHIJ3SFvmrv5OmRAWb7cwk1FLb87KKaS7JwtQ42vmxgGLcb2xbAESSZNVjvfB@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnXNV1rGFbW6ntEsnaMLEEScKgAbpJlg5ARFl9Vine21bcvLQ
	e5uMD8QlAQRl6TQdATvguaWDLPoVGIYspdGqbaa1Z5G1lBhoM+DjYJR7
X-Gm-Gg: ATEYQzwRzx/WZzBeEWSivp20dx0SeRD2bNpyphy9tW0tuYi8RkEGpTSDI5lF9uUhmpR
	teE65TCLPar6uSbmXw1NPfUHut+TNAWuYWSvSjktBIOPCqF+HdHTKRi//11mbdeFZ+GsrgbNxNa
	knVOyTqjrYkpEa4/Q4qvhGohz7i1BkCO3lvTDEbYdgk5WV5TEP1b7cfL1txXxhdzim4yW2bkJF2
	P8eItWifZOBaL8e5D8C086Pm2+64Bpuo2iKqkwtniXLBH1RN6zuSuk3XVxxkte3tSyO77iqj8/n
	zUgJzEkkohr2wKKzoNYjkL85UnQk7rq0ayVgMysjMjg9Wr2A2dmQeltg0uGYygOTseuBfMy8NOm
	eh3wkggVjw2b3UiYL1CMDe6w+ktkSFvPOUuUiHJ1skVoT31QiddhYv3WaZzWoh7IsEIRfZ29zPq
	IMe2+SorR7plGwMG5wphpfrsNnDYGoIQOQNZu+
X-Received: by 2002:a05:7301:678a:b0:2be:ca4:e10b with SMTP id 5a478bee46e88-2be0ca4f0d7mr701712eec.35.1772409239681;
        Sun, 01 Mar 2026 15:53:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f49d96sm8755978eec.27.2026.03.01.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 15:53:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 1 Mar 2026 15:53:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1 1/3] hwmon: (acpi_power_meter) Drop redundant checks
 from three functions
Message-ID: <cc3d0465-d035-49c0-ac0e-f344e68f77d3@roeck-us.net>
References: <5974797.DvuYhMxLoT@rafael.j.wysocki>
 <5085645.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5085645.31r3eYUQgx@rafael.j.wysocki>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21291-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F7C81D1FB8
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 02:17:19PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Since acpi_power_meter_notify() and acpi_power_meter_remove() are
> .notify() and .remove() callback functions of an ACPI driver,
> respectively, the first argument of the former and the only argument
> of the latter cannot be NULL.  Likewise, the acpi_power_meter_resume()
> argument cannot be NULL because it is a system resume callback
> function.
> 
> Moreover, since all of these functions can only run after
> acpi_power_meter_add() has returned 0, the driver_data field in the
> struct acpi_device object used by them cannot be NULL either.
> 
> Accordingly, drop the redundant "device" checks against NULL from
> acpi_power_meter_notify() and acpi_power_meter_remove(), drop the
> redundant "dev" check against NULL from acpi_power_meter_resume(),
> and drop the redundant acpi_driver_data() checks against NULL from
> all of these functions.
> 
> Additionally, combine the initialization of the "resource" local
> variable in acpi_power_meter_notify() and acpi_power_meter_remove()
> with its declaration.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied.

Thanks,
Guenter

