Return-Path: <linux-acpi+bounces-20975-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM9iMFwfj2kwJQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20975-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:55:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D413629B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080173028B07
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E435F8A5;
	Fri, 13 Feb 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu8OTjwy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5435E557
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770987353; cv=none; b=HuiTiZ0W0GG/lYPtc9gWUhH+PScjLaOmrnozAZSkeGEg3VVqj2xexgEmRsniD0wCB5pw8PFldDVxCUvOcwy4QUB7XyHnNmdnzcXyGXl14+km3aX6EgiW9r8+JoeLeDeT30Ad0Btfg5kv7m5b9cXfLegOvG6dyCboaliPhs4ic3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770987353; c=relaxed/simple;
	bh=cQ/FnzU42SY+3vkKbTj7jh8rd1tJiRiqBr24klrgw+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hj5rcXV7C7M5/eqGiHpHosue/PZwt/gnuQOqxEHstTkeU5Wj8om2VHIcK2hYgzpER+MDQtF0AJD6wo2qXBuU46Jt8xBYeQrBnENn9Zf7w3vlGsmnKnpcDVfh+afT4uIwqXd/RtnoVn4Oke5bQ7HCJY4lA8qFxhk4VUqKkjgVKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu8OTjwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D402CC2BCB0
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770987352;
	bh=cQ/FnzU42SY+3vkKbTj7jh8rd1tJiRiqBr24klrgw+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vu8OTjwy2DoTljHHwa/t1dhjyJpINwLwK+8P2SLWbXdiFFm1Ku4f3jtIChir7Vp0m
	 72Va6JhpUyTcFEbqaGeIvySrWTMAt0HzBhvtX1g20pMB4jjxEi/5fIAu1Lhs9x6y/q
	 ZxqY7yovrwuWSRd6Z386HUvsnSSDVu7IO6kh8mg3WVpUh/m9jyjs3kem1BIqJ+Q9pm
	 IoTD6XcP6PfgFiv98PngJMhVOWBGwc9CeYAgESbXlP6FzRYkOYSdbme+qkop8cMbJP
	 igkz6tiZfniL21Y5VjyCp5lxqnJ0UNV/8I1eK0IQAtJ+md0QlTcALr9E9M/MlouEfc
	 SXJ7mtlEQuooA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40a62601731so514139fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 04:55:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBBmma0oqDC8AZyRIkUpDP9Cm509+XsY7832R8RhxHYc1Qd6EsoAGK11XR9341znQ1x7NICXZOh4W8@vger.kernel.org
X-Gm-Message-State: AOJu0YygUFwHOoS34Mrf8FVnntk7Mgv89b+MakSfUwZB5jmxlKTtp4i/
	yO9h0VBHNzQoMHHUxqmg9GuZ9W36608QhoBAbVhumtYx8CN72Hc5EHwgsb5F2ca5rYlwP0MucKg
	FSXukICMFSJo6JFZpUIh8xM94M30Z4Bo=
X-Received: by 2002:a05:6871:8114:b0:375:270b:ea56 with SMTP id
 586e51a60fabf-40ef40a560amr848008fac.42.1770987351835; Fri, 13 Feb 2026
 04:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213065351.915707-1-corey@minyard.net> <20260213065351.915707-3-corey@minyard.net>
In-Reply-To: <20260213065351.915707-3-corey@minyard.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Feb 2026 13:55:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i-Yium3PrSE0XU4ZYikco0DRBqbR3jmogaeOw1TSeunQ@mail.gmail.com>
X-Gm-Features: AZwV_QjNRaalcczGZ4lB9gvU_wV-tyM6YeXxIgeQqG7bkJ5kpExAQ6JdcDNPmiA
Message-ID: <CAJZ5v0i-Yium3PrSE0XU4ZYikco0DRBqbR3jmogaeOw1TSeunQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ipmi:msghandler: Handle error returns from the SMI sender
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20975-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,minyard.net:email]
X-Rspamd-Queue-Id: 615D413629B
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 7:55=E2=80=AFAM Corey Minyard <corey@minyard.net> w=
rote:
>
> It used to be, until recently, that the sender operation on the low
> level interfaces would not fail.  That's not the case any more with
> recent changes.
>
> So check the return value from the sender operation, and propagate it
> back up from there and handle the errors in all places.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functi=
onal")
> Signed-off-by: Corey Minyard <corey@minyard.net>

The changes in smi_send() are what I would do there, but then I
wouldn't know how to take the return value properly into account in
some cases.

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 97 +++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi=
_msghandler.c
> index a042b1596933..c209486bfee7 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1887,19 +1887,32 @@ static struct ipmi_smi_msg *smi_add_send_msg(stru=
ct ipmi_smi *intf,
>         return smi_msg;
>  }
>
> -static void smi_send(struct ipmi_smi *intf,
> +static int smi_send(struct ipmi_smi *intf,
>                      const struct ipmi_smi_handlers *handlers,
>                      struct ipmi_smi_msg *smi_msg, int priority)
>  {
>         int run_to_completion =3D READ_ONCE(intf->run_to_completion);
>         unsigned long flags =3D 0;
> +       int rv =3D 0;
>
>         ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
>         smi_msg =3D smi_add_send_msg(intf, smi_msg, priority);
>         ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
>
> -       if (smi_msg)
> -               handlers->sender(intf->send_info, smi_msg);
> +       if (smi_msg) {
> +               rv =3D handlers->sender(intf->send_info, smi_msg);
> +               if (rv) {
> +                       ipmi_lock_xmit_msgs(intf, run_to_completion, &fla=
gs);
> +                       intf->curr_msg =3D NULL;
> +                       ipmi_unlock_xmit_msgs(intf, run_to_completion, &f=
lags);
> +                       /*
> +                        * Something may have been added to the transmit
> +                        * queue, so schedule a check for that.
> +                        */
> +                       queue_work(system_wq, &intf->smi_work);
> +               }
> +       }
> +       return rv;
>  }
>
>  static bool is_maintenance_mode_cmd(struct kernel_ipmi_msg *msg)
> @@ -2312,6 +2325,7 @@ static int i_ipmi_request(struct ipmi_user     *use=
r,
>         struct ipmi_recv_msg *recv_msg;
>         int run_to_completion =3D READ_ONCE(intf->run_to_completion);
>         int rv =3D 0;
> +       bool in_seq_table =3D false;
>
>         if (supplied_recv) {
>                 recv_msg =3D supplied_recv;
> @@ -2365,33 +2379,47 @@ static int i_ipmi_request(struct ipmi_user     *u=
ser,
>                 rv =3D i_ipmi_req_ipmb(intf, addr, msgid, msg, smi_msg, r=
ecv_msg,
>                                      source_address, source_lun,
>                                      retries, retry_time_ms);
> +               in_seq_table =3D true;
>         } else if (is_ipmb_direct_addr(addr)) {
>                 rv =3D i_ipmi_req_ipmb_direct(intf, addr, msgid, msg, smi=
_msg,
>                                             recv_msg, source_lun);
>         } else if (is_lan_addr(addr)) {
>                 rv =3D i_ipmi_req_lan(intf, addr, msgid, msg, smi_msg, re=
cv_msg,
>                                     source_lun, retries, retry_time_ms);
> +               in_seq_table =3D true;
>         } else {
> -           /* Unknown address type. */
> +               /* Unknown address type. */
>                 ipmi_inc_stat(intf, sent_invalid_commands);
>                 rv =3D -EINVAL;
>         }
>
> -       if (rv) {
> -out_err:
> -               if (!supplied_smi)
> -                       ipmi_free_smi_msg(smi_msg);
> -               if (!supplied_recv)
> -                       ipmi_free_recv_msg(recv_msg);
> -       } else {
> +       if (!rv) {
>                 dev_dbg(intf->si_dev, "Send: %*ph\n",
>                         smi_msg->data_size, smi_msg->data);
>
> -               smi_send(intf, intf->handlers, smi_msg, priority);
> +               rv =3D smi_send(intf, intf->handlers, smi_msg, priority);
> +               if (rv && in_seq_table) {
> +                       /*
> +                        * If it's in the sequence table, it will be
> +                        * retried later, so ignore errors.
> +                        */
> +                       rv =3D 0;
> +                       /* But we need to fix the timeout. */
> +                       intf_start_seq_timer(intf, smi_msg->msgid);
> +                       ipmi_free_smi_msg(smi_msg);
> +                       smi_msg =3D NULL;
> +               }
>         }
> +out_err:
>         if (!run_to_completion)
>                 mutex_unlock(&intf->users_mutex);
>
> +       if (rv) {
> +               if (!supplied_smi)
> +                       ipmi_free_smi_msg(smi_msg);
> +               if (!supplied_recv)
> +                       ipmi_free_recv_msg(recv_msg);
> +       }
>         return rv;
>  }
>
> @@ -3965,12 +3993,12 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_sm=
i *intf,
>                 dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
>                         msg->data_size, msg->data);
>
> -               smi_send(intf, intf->handlers, msg, 0);
> -               /*
> -                * We used the message, so return the value that
> -                * causes it to not be freed or queued.
> -                */
> -               rv =3D -1;
> +               if (smi_send(intf, intf->handlers, msg, 0) =3D=3D IPMI_CC=
_NO_ERROR)
> +                       /*
> +                        * We used the message, so return the value that
> +                        * causes it to not be freed or queued.
> +                        */
> +                       rv =3D -1;
>         } else if (!IS_ERR(recv_msg)) {
>                 /* Extract the source address from the data. */
>                 ipmb_addr =3D (struct ipmi_ipmb_addr *) &recv_msg->addr;
> @@ -4044,12 +4072,12 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi=
_smi *intf,
>                 msg->data[4] =3D IPMI_INVALID_CMD_COMPLETION_CODE;
>                 msg->data_size =3D 5;
>
> -               smi_send(intf, intf->handlers, msg, 0);
> -               /*
> -                * We used the message, so return the value that
> -                * causes it to not be freed or queued.
> -                */
> -               rv =3D -1;
> +               if (smi_send(intf, intf->handlers, msg, 0) =3D=3D IPMI_CC=
_NO_ERROR)
> +                       /*
> +                        * We used the message, so return the value that
> +                        * causes it to not be freed or queued.
> +                        */
> +                       rv =3D -1;
>         } else if (!IS_ERR(recv_msg)) {
>                 /* Extract the source address from the data. */
>                 daddr =3D (struct ipmi_ipmb_direct_addr *)&recv_msg->addr=
;
> @@ -4189,7 +4217,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *=
intf,
>                                   struct ipmi_smi_msg *msg)
>  {
>         struct cmd_rcvr          *rcvr;
> -       int                      rv =3D 0;
> +       int                      rv =3D 0; /* Free by default */
>         unsigned char            netfn;
>         unsigned char            cmd;
>         unsigned char            chan;
> @@ -4242,12 +4270,12 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi=
 *intf,
>                 dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
>                         msg->data_size, msg->data);
>
> -               smi_send(intf, intf->handlers, msg, 0);
> -               /*
> -                * We used the message, so return the value that
> -                * causes it to not be freed or queued.
> -                */
> -               rv =3D -1;
> +               if (smi_send(intf, intf->handlers, msg, 0) =3D=3D IPMI_CC=
_NO_ERROR)
> +                       /*
> +                        * We used the message, so return the value that
> +                        * causes it to not be freed or queued.
> +                        */
> +                       rv =3D -1;
>         } else if (!IS_ERR(recv_msg)) {
>                 /* Extract the source address from the data. */
>                 lan_addr =3D (struct ipmi_lan_addr *) &recv_msg->addr;
> @@ -5056,7 +5084,12 @@ static void check_msg_timeout(struct ipmi_smi *int=
f, struct seq_table *ent,
>                                 ipmi_inc_stat(intf,
>                                               retransmitted_ipmb_commands=
);
>
> -                       smi_send(intf, intf->handlers, smi_msg, 0);
> +                       /* If this fails we'll retry later or timeout. */
> +                       if (smi_send(intf, intf->handlers, smi_msg, 0) !=
=3D IPMI_CC_NO_ERROR) {
> +                               /* But fix the timeout. */
> +                               intf_start_seq_timer(intf, smi_msg->msgid=
);
> +                               ipmi_free_smi_msg(smi_msg);
> +                       }
>                 } else
>                         ipmi_free_smi_msg(smi_msg);
>
> --
> 2.43.0
>

