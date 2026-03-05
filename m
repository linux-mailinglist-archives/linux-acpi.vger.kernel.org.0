Return-Path: <linux-acpi+bounces-21417-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oENKDjCAqWkd9gAAu9opvQ
	(envelope-from <linux-acpi+bounces-21417-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 14:08:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F318212672
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 14:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1377D30F9B79
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C63A1A36;
	Thu,  5 Mar 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUQBtpc4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9139F167
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715730; cv=none; b=ZVoVNRU40++er+AOWbFSarXJbVN+FyWA3NSF9B1ZSklDjjwqdkytW48MeltN6pS/hIljPHsMrh75Ef5JqJ0QFTy5eAeBqN9LRm+h+4Ld2nZOk7kIB8Dxm53eb+nPuxWdO0iAODByqOBB0a2xnhS4YWJd+zz4OXcBEGn00jevUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715730; c=relaxed/simple;
	bh=Y3PQBbklIoBSVs1Uf2NtADUm7Wrj/63rh2E73LlCo6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSFYlMaRDi+L9XzBL+9lRqCIbMb+QSXU1UNm5SXeW+4xljxS+oKr7QrbyNH1Q7umM98+BEuIKEsKo5iuhF1iOXQZO1UrcxmL/BQLcB03Ad9cLQKeSpkB9/bdPQEs2plc+j8g2tDl9cDAUA7tTXX6biRBhXzZgQb4pVqrpCcdCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUQBtpc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9548EC2BCB3
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715730;
	bh=Y3PQBbklIoBSVs1Uf2NtADUm7Wrj/63rh2E73LlCo6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gUQBtpc4AVHgDACLeg6f/Qu9tYym9mDpMpfFAt++bfyM4b7g8GNRJN+oKvhUL+ZdN
	 MRXvR/coeidbwzWpGQa0hmjBJ+lBoWzv9Dg6dlMihJs+yNcAlGwvrCYTv+anr1eclw
	 zbFWvqiyXYHn3klxyHm3xLT9yita5t6r8Dnx4kCEjswvK9Rx+aRT36oVBkPtEDMMp/
	 12JeEQgqYRN+wGdx8Ih5PijNfVQtqi4NLPI/kCqww69uu2Q0MiX22L36Pi+fqEpL62
	 b70kAj3IaF4mb941ZyB0//BtVIJQmIoNh+B1XGXPeFsM+xELi2DoY4LbOz42ha9G5Q
	 gvrfcUTqGCZVA==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-797ab169454so80727447b3.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 05:02:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/SCJe90J7WhFu6IvLZ8yyej5LZIrht09YoZ1g414rI4macjipvwr8xyLOSw699WkIirtkAI+1/xIE@vger.kernel.org
X-Gm-Message-State: AOJu0YwtpK9PoMlfsm9rvW4p5n494ObvwnqnoBkA0J0GmYp+ENV9dmnJ
	dweqqsPESr3QsuYIvj+YUVQGpcbEBCBggqSlqRt8j7JkZExz6X/Qjp5fIUvS+KAYckJsJ9Cdyql
	fCRsGIdKD8Cc1AWQnZYJ0OX0yVBV6u+Y=
X-Received: by 2002:a05:690c:f09:b0:794:dac2:89de with SMTP id
 00721157ae682-798c6be38f0mr48176717b3.17.1772715729820; Thu, 05 Mar 2026
 05:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-6-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-6-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 14:01:57 +0100
X-Gmail-Original-Message-ID: <CAD++jL=cZ59F1X6Yz_9cOvBLq+Vc4_OZWN+tTUqpStS5PXbV7w@mail.gmail.com>
X-Gm-Features: AaiRm528EaLwv_KXrf5uesPMaGbWTVKCJzU5xf6797RKygLsnD1f1zGkjbql-ms
Message-ID: <CAD++jL=cZ59F1X6Yz_9cOvBLq+Vc4_OZWN+tTUqpStS5PXbV7w@mail.gmail.com>
Subject: Re: [PATCH 6/6] gpio: sim: allow to define the active-low setting of
 a simulated hog
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7F318212672
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21417-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 10:52=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Add a new configfs attribute to the hog group allowing to configure the
> active-low lookup flag for hogged lines.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

If you add an explanation to why this is needed (I can think
of a few) then:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

