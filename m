Return-Path: <linux-acpi+bounces-20974-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH7JJTMej2kwJQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20974-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:50:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DF6136269
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42336302C305
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEAA35DD15;
	Fri, 13 Feb 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXRDNGwL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FD3EBF00
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770987055; cv=none; b=kZz8B3llGwg7XknIA/QzBEeXLC452l4jLV46ULgMO+bgRAzKQrBu358OTXk0mBiteH1JIE8V591nZzKL0J598BMbbIi8fZy7Owd7iBVyB6vSeqVnm7fFUonlUC8N2ijVw5P8Tgr3dKF5jJE1zhyxt4so7syVfdzIwf8BAExBg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770987055; c=relaxed/simple;
	bh=RcnlKBAIMTEriay3ZCo95c84xOs/bq0HtgdRo6bkQNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqgjPd5acxDzmCuJWOlgsMYibz9yVKkq9Tg6al0Z+KTRbny67it+td3rXEtVX0LE7+cWVxd/JDJ7sGDiVuqdBdjzkBcEXI3rNYJxJLRoU2vjRqqK/onuCWXps2XJZkrb6woZMNrUUMo36+PlPRDv/QAMG8+u9Ce20nOc/38o4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXRDNGwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A2FC4AF0C
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770987054;
	bh=RcnlKBAIMTEriay3ZCo95c84xOs/bq0HtgdRo6bkQNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IXRDNGwLoHMIdkMwawoTNn5YJ4nAJgrvqP/uMG42NlBYR5kh29tKLRsRcYyxXDCfE
	 ZGkoOnwZgKxMahzDii/DRdg7Wci1cEA0BLp/vrqcZw5qU8CWTwmDjlNIfVQAeA9Z4g
	 py3k8PZSULHqtC73zc5nkAvuyB2cu6V4HWxsxog76a64WSaZiF7p4PXP8fo/LrPLuY
	 ijHXN3DWOPg3VbsXeYej4wdaLTy/s3FcuwQAidAp8qsBlJG/NPSqJVjqzysl5Wn7c5
	 Ip4KhYcGhjwaPtfDH5x8CfNy3K42V5e9fw4fOW6pCieRu6Z22eG60bh65AKjJcwzxg
	 jJ6j+QL+PyIKg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45f015a3259so283106b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 04:50:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuGcLCUsJsRe5cqI7TMVS8KSB1qZF/eh0LXzlxD9iQSJAeCEtmLtEaUfZk5TylZBlg5l5mZouAfKzE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4O4JCBunrHvj6oQxe2SRaqVUdQVGxJ0HG6h7XouoVZGqRJYHT
	LyjY6BBMbEs54t3Va3yaeuIZlkXd9M0Wtz0xguXIlqnmjBMoHcnTw5a8OINjw3demAes/WQxQJ4
	CGue9j5B1pTlTES7wN87lXFavrNlE+QA=
X-Received: by 2002:a4a:e84b:0:b0:662:c8be:573 with SMTP id
 006d021491bc7-677697878a4mr670627eaf.61.1770987053886; Fri, 13 Feb 2026
 04:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213065351.915707-1-corey@minyard.net> <20260213065351.915707-2-corey@minyard.net>
In-Reply-To: <20260213065351.915707-2-corey@minyard.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Feb 2026 13:50:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hO=2-6fF5NzgXmuNDDFszKizMa9wFoxZQmCT0k-e6_9Q@mail.gmail.com>
X-Gm-Features: AZwV_QjCLJjvhgY2ZE92RvQiCYya7ewxlvWFxkjsayVw5RK0UMgJp6xRBTDMuz4
Message-ID: <CAJZ5v0hO=2-6fF5NzgXmuNDDFszKizMa9wFoxZQmCT0k-e6_9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ipmi:si: Don't block module unload if the BMC is
 messed up
To: Corey Minyard <corey@minyard.net>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20974-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,minyard.net:email]
X-Rspamd-Queue-Id: 56DF6136269
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 7:55=E2=80=AFAM Corey Minyard <corey@minyard.net> w=
rote:
>
> If the BMC is in a bad state, don't bother waiting for queues messages
> since there can't be any.  Otherwise the unload is blocked until the
> BMC is back in a good state.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functi=
onal")
> Signed-off-by: Corey Minyard <corey@minyard.net>

I have missed this case, but indeed it needs to be addressed.

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si=
_intf.c
> index 0049e3792ba1..3667033fcc51 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2234,7 +2234,8 @@ static void wait_msg_processed(struct smi_info *smi=
_info)
>         unsigned long jiffies_now;
>         long time_diff;
>
> -       while (smi_info->curr_msg || (smi_info->si_state !=3D SI_NORMAL))=
 {
> +       while (smi_info->si_state !=3D SI_HOSED &&
> +                   (smi_info->curr_msg || (smi_info->si_state !=3D SI_NO=
RMAL))) {
>                 jiffies_now =3D jiffies;
>                 time_diff =3D (((long)jiffies_now - (long)smi_info->last_=
timeout_jiffies)
>                      * SI_USEC_PER_JIFFY);
> --

