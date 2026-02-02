Return-Path: <linux-acpi+bounces-20810-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLbmAHj3f2lI0wIAu9opvQ
	(envelope-from <linux-acpi+bounces-20810-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 02:01:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5DC7B33
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 02:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21C53004F66
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 00:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142301D61B7;
	Mon,  2 Feb 2026 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbtY6Pwq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F51B6D1A
	for <linux-acpi@vger.kernel.org>; Mon,  2 Feb 2026 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769993762; cv=pass; b=HrURgLMDAztPhvq8nYpW+2Qx+OJGbq0YKG0X3I/47Iw7i8Cjr4fCNKNmarF71OQG1yc1Bshb8QOeV9mdf1cvDvPuvvSG/2JQlvf76GsDIUBz63rxDvr8DewrS0Ju7LFh/lUFfxirkZnvmi9I7D8tHBgC17lQby6y1hOtm4MaAA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769993762; c=relaxed/simple;
	bh=N23TbYoVQf+5IZEfUpO8/GsVvBLx9XUGKgJxDfiQSvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeDY9jtlAMsbSAfAjPRNMHGSqpSyvSi84qWgvkBLqDL4KRkZa+bJkj7JT3W8EcB27i/dBBZetSKpgKWnexZWWRJanzHIS8FgP1A7fo7TX2LG6NA47qLa86M+AeAI781rwHLL5GUQdl8mG0Khydmak/+ymUpghzk+e289S9wucWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbtY6Pwq; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45ee8823e2aso2456846b6e.0
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 16:56:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769993760; cv=none;
        d=google.com; s=arc-20240605;
        b=StLln2v6An3ElHl7XbMMVd295oyA2N+s9vuQ0jAAca96kZISFZb3zjG+KINgivV4KJ
         M6EL5jmKq5aFYBMCexKp2BqgQGU3rOhxL+ExMgWWpgurmFNadpB/rqwQ7TBZ0ezhlKBe
         tvk6KJXJ9Fo7Xj+ufPmI8Fz4/DkYkMFRNwu57cdwkkO2Lg+C1qltpsMYYYuTjLgdxJLg
         Z0OLqBZ0AsNJ576K93xT42c2b5Rym1FhKaurbJJ5smFKvxT0+0cjryap/fB03fESoB7W
         wKH82JZyZZeOrCvv/Z7cEvAi4l3v1W8+cDWU/WnEUxrySHkpqxPLYQFqjgl/K3k8uta+
         PImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oH2ptcHM2obF71tYdVPI/xt/XvRDpGfvZzkpZThokms=;
        fh=+JL5pesi/i0ey7/UPQnH/MWyMh5uxNT4oc1ph5ZNmV4=;
        b=NzGmjVF4acXtPCcvkQN9vEPnZz815FicEqF+l5pJ0Px0eLHXqcigsosG9LJmILbTdD
         vYzjSQoGmwXr4maMePMfTCSb27LXxZOCD9rTal1Sy/rUXwcm5Y8wDicTl4wUPkPHYJMX
         ia2ThRMfkNYjcmCgYVDGfH2UvEOBqwsLM4xZ9+Tbb/eI/NitTkUmBdfFGxVCvj4yPVOA
         ArgdSDG1Fb+jXMJl93Kh7k1VydLwfIwZflDXZrKq+/Qx5v6hFcW/5qS8yg3xaSf5MAEw
         WkACDddC6b8KMD8wfCdUMfEZKKbg0+py85nOxmzCU1ufuswA2BuT5QDRYfj7uUQ5yu5r
         zEbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769993760; x=1770598560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH2ptcHM2obF71tYdVPI/xt/XvRDpGfvZzkpZThokms=;
        b=kbtY6PwqI7mC8mGmDah96UdQCkJCb1svnBbekzAvQ+tFOi+q5QOe7ugGc4L1DD/VtK
         30By9dsmamjdRGCrjM46dKTPnhheNP1ggHqr/THSCXAiDYzWCJCpbpY9YGsrcAPpHmlP
         lRSOFWJvrJI+mzOOWVuR2z3yOUKRCcLfr9isyCdGtmp4179iYJsiUN6FPaKWK/DkYl62
         D17pSOVYVfZ8ZQvGo/sXFz1POMYR23kZrkt8OLsqxmePW07lBPxtVIfF+tk1tG8V2Thc
         5NuKN825Q91BuVt92T/Cr8f0S23dXDkLPxWLsYfd5shajFld00/Q1e246aaIFEfd+p7w
         MEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769993760; x=1770598560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oH2ptcHM2obF71tYdVPI/xt/XvRDpGfvZzkpZThokms=;
        b=SNCnJP2EQCK1hCM+GNWYVQCjR25oHRsGqvYUkAHWlX5XPjuxstuxLhIKqHBZewZISi
         J03jole4uf5+27wzeycl7bDVQqjhW0Nfz3xV5zL74u+gBKvnJgxwQxYzNT0Dj9ecOG07
         S7N7eNgDJkmw+JqpU3JWBSjayd4FbGJMtHBDyvMhYKZjtuZKhZTMBNV+JbaFxi1fHWO6
         AtFEcyZahF2zxbCSJqqmT6KjBKug25tsfYiixqRKsLN8eVu7cdUtnw8NjKkjbBfJWNVI
         ydKwX0NSntaXw5MDuQc3KjiF/52SJLmenO7V/xCae19hgPqcE/W7mVXYJhjuzafMJvuE
         MaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOlvsf0xkX6LRhwQzdlJbCWvyMIPwKPwJkcRhAxK5bHwPy7bMmyZ7rQ8Sz8YtiLos2pCGpxCGzgJyY@vger.kernel.org
X-Gm-Message-State: AOJu0YzBssPDBQ8L2PkyO1bt3w4wWEaiJs5AjKLpi0HLC0lGhiPPWiLl
	a14KRhAxCiYMpyvn6A8ASHrIjrY8j6tBZdJolUHvy3DzoKRLqqB8KE+4d04XQyskS65TSAEPDHN
	r+E9JYlS80pG/fwqFjGQGNM1drHzYaf4=
X-Gm-Gg: AZuq6aLWWRyXMEBBLxnWvZbSUqsMUvFdOnCQ3Y/+cZtBV5VJb6/WuXIJNStHLjo5/Qe
	UQA55yN+g1YmUIyTcOV1+v8w5DWvBlNtk5j7BhNP5X/GkEVBAhKzeEWhC2x6VvnYSW/q1VfpDpZ
	f5rCSzMwfe+VOrV32MWgUuUKTeOj1AlfqHHTUrijlIak+hOtBiMnZVNGHqwG4DFm6sSJbg2RVF4
	gCuUMg0aVtooByTRk3NVzwbaSGysYYaqX+o0AJDfUk7X9UzYW/gxRi5a3rRf/necqkgA9bQ9fgJ
	4osrYqc=
X-Received: by 2002:a05:6820:814:b0:663:c86:e9de with SMTP id
 006d021491bc7-6630f03720emr4142757eaf.20.1769993759765; Sun, 01 Feb 2026
 16:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-mailbox-v1-v2-1-54936bb08f15@nxp.com>
In-Reply-To: <20260128-mailbox-v1-v2-1-54936bb08f15@nxp.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 1 Feb 2026 18:55:48 -0600
X-Gm-Features: AZwV_Qj2OGrBXCTa88C3pjzhWmkSCShKfiSn_icOlANJXamPppB9QliTmAxQVsY
Message-ID: <CABb+yY3D54V0fe-bW_dMVmN7nf4KzJ7ZbvDkwd6P1wXYmix4aw@mail.gmail.com>
Subject: Re: [PATCH v2] mailbox: Remove mailbox_client.h from controller drivers
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>, Yuntao Dai <d1581209858@live.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	mailbox@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20810-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[ti.com,live.com,vger.kernel.org,lists.linux.dev,nxp.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81F5DC7B33
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 6:32=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> mailbox_client.h should be used by mailbox consumer drivers, not mailbox
> controller (provider) drivers. The affected drivers do not use any mailbo=
x
> client APIs, so the include can be safely removed.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Drop changes to pcc.c
> - Update patch subject and commit log
> - Link to v1: https://lore.kernel.org/r/20260127-mailbox-v1-v1-1-cf15d7ce=
ce48@nxp.com
> ---
>  drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
>  drivers/mailbox/cv1800-mailbox.c     | 1 -
>  drivers/mailbox/omap-mailbox.c       | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-f=
lexrm-mailbox.c
> index 41f79e51d9e5a92089a3fd798e848d837fb2775a..5d278bb5a4c0635dfc46b4a6d=
c3addf0b3b5d1be 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -26,7 +26,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_controller.h>
> -#include <linux/mailbox_client.h>
>  #include <linux/mailbox/brcm-message.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> diff --git a/drivers/mailbox/cv1800-mailbox.c b/drivers/mailbox/cv1800-ma=
ilbox.c
> index 4761191acf782654c1724df2c9cc619e1d7c985c..4bca9d8be4ba2c8debf6e48a5=
ddc2873f14b64fd 100644
> --- a/drivers/mailbox/cv1800-mailbox.c
> +++ b/drivers/mailbox/cv1800-mailbox.c
> @@ -11,7 +11,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kfifo.h>
> -#include <linux/mailbox_client.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbo=
x.c
> index 17fe6545875d01606b80e678fca82bf44f6eaffa..d9f100c18895224cf323b073d=
b93ce94d7e16d18 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -21,7 +21,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mailbox_controller.h>
> -#include <linux/mailbox_client.h>
>
>  #include "mailbox.h"
>
>
> ---
> base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
> change-id: 20260127-mailbox-v1-1461cd2955fe
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
Applied to mailbox/for-next
Thanks
Jassi

