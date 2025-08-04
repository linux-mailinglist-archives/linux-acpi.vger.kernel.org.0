Return-Path: <linux-acpi+bounces-15524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F46B1AA0E
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 22:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C94E18047F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07E222586;
	Mon,  4 Aug 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fsd8vl27"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E4219E93;
	Mon,  4 Aug 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339136; cv=none; b=UssedcJzNgH2KkwTM43sxirkcdLIMLd3CmUnxbOjpdmnJm8exBGkVBCifUpswA7rUpd8/CIUdfr/ihVC7MJ2MZds5y3a41WS1U24zRUpUuTVHyXFjSPlTjphwuanSpmOSCLF1ysoKh3h/LbSQfXomBSn6rzoLXAWenl6NzdeBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339136; c=relaxed/simple;
	bh=dGgpH6gwtRoBFvZBeky55WocZ6/31ZO/1l8ElUMZKtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=suaSqtpGU3lgVWJGOngIwrkzZXHgwO7u5U8pkxcYpgOec7cDqhMgJSG/3mmBenWgbXzqMKI4ikvSDHOmvQrq2zt56NPQz6aX+gorsXr4/qXDr23S0qMGs2NlpNyhyoPS0gFm5I2VtECWHEyq84q/A5ioayte7QE0cbgPRSSPnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fsd8vl27; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754339107; x=1754943907; i=markus.elfring@web.de;
	bh=KOX4QJhrYzw8nKxF5MH4/N723uIDdGwpPl2R8p8sZOE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fsd8vl27gmABuH3AvFnaj6SrAyZ6CHp0f0sTIE+xgvbOhK0usGPOB2cf6qrBuzfU
	 TWKRiJ99IDImfCzHBMgLZBUQXNaJko4/GEfO+WpovM+fdpwQS33zCKtJF//JadqtQ
	 R2eQob2SadGiZ3YX8QMG/BxRuxT4NxXFmG5QxXQVilgicSCiSju//iKl9BpXa+Xcw
	 yFqqLE0wxdjfXL0+tdhr6ao1NI5bxpK5A8gWXoef/98CX+BIjfxliaHDC9CmryPFw
	 JU59nNwtg9ZwWkZFymIUpPTp4Zb+5V0xVAr2pdwvw/hvNFMtTqJ36v4fXuYOiwfQ+
	 LZYUNmr+KS2DdSjXfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mae3c-1uCivg38Z8-00lpQb; Mon, 04
 Aug 2025 22:25:06 +0200
Message-ID: <927e03af-6682-44c5-9225-fb269b0a6e1c@web.de>
Date: Mon, 4 Aug 2025 22:24:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] acpi: remove unnecessary return parentheses and
 conditional braces
To: Diksha Kumari <dikshakdevgan@gmail.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250804185826.29723-1-dikshakdevgan@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
In-Reply-To: <20250804185826.29723-1-dikshakdevgan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EngeTMD8wxUh8vQHUxcWbjcqwLe6EHpRBSz7g9GKQkSkptU7Ejy
 mTJ5HjX6nbFhCZcc9nR99gxpxrwyvy6wXnoL8q04swLLdyFj47r2Ir0F9+iPdr0gaGvuQkP
 r8kmEhMLuJvJPOYVVCkrf+PtOTZaAGBreizvUshVDzkFfkSnHELfofvkWwaTGmwOXUzzkbz
 xh/8XRNWuZY6I3hdCKrtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I5wNMSbmLL0=;s95AXCMYu1DJA9/oelmgnfps6aa
 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

> This patch removes =E2=80=A6

See also:

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16#n94

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16#n658


=E2=80=A6

> These changes address checkpatch.pl warnings and improve code readabilit=
y.
>=20
> v3:
> - Updated commit message
=E2=80=A6> ---
>  drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
=E2=80=A6

Please move your patch version descriptions behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n784

Regards,
Markus

