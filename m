Return-Path: <linux-acpi+bounces-2180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003058077BB
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9041F212AD
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 18:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAE482C3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 18:42:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D97FA;
	Wed,  6 Dec 2023 08:42:29 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58dd5193db4so593381eaf.1;
        Wed, 06 Dec 2023 08:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880949; x=1702485749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIMxSzHR3qe9Kpm2WxCB7U+8a2fot2Cq5eXT0G3opo8=;
        b=SymsvCjQpV+N/1iiNY8gtAWu6dysHek206tip0KT4Kuo+KVTiK69Oc9ypgxj2ucRiz
         jHGgKFVkh4mIDEztWqC+eJRsK/frp1m9KKxtOs/rN7+R0CGkwKD0ZMS0gvrV0l++e1OE
         QICWMXFibwSJXK/3g4Sf6hQFHDW3Au/jJq8x/HoNl1w/tqvdiFCP8OsmO6cUOBfqJzIR
         cnQuHBkMOFICC3R3RcKp9AXL8s5C/X2G8GMVVgA5DQRfOSOyBiaHRImAULbyHTyMGVin
         sCppIT+xyu0utkKMsGzD/r1vFpUyqBh6yL/0DsYBybpJE7e2Vhupx/GZFfgzQ3hTBCCV
         LJIQ==
X-Gm-Message-State: AOJu0YzREgrCDe2MXkmltxuOnJbjHMGOHT5XGz22AfWQCGBwm35ixLZ4
	nzM9yp7YK8bpBXCkC/WIpvcLLl2gOK6ucz94SkI=
X-Google-Smtp-Source: AGHT+IF+3Ncf78ciIJeaNwWxRt+lcWpdhggiA3DAS/EzgAxn6GAxK1TNZCKnSlGnWwIZVQUmD20k7Sw8beVn2OvHVvE=
X-Received: by 2002:a05:6870:1481:b0:1fb:1d07:86a6 with SMTP id
 k1-20020a056870148100b001fb1d0786a6mr2047259oab.3.1701880948896; Wed, 06 Dec
 2023 08:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120114143.95305-1-ytcoode@gmail.com>
In-Reply-To: <20231120114143.95305-1-ytcoode@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 17:42:15 +0100
Message-ID: <CAJZ5v0ijJeOLJo=ooru9raj0n=iiGybFCud42Z+EEtncgNk47A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Correct and clean up the logic of acpi_parse_entries_array()
To: Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 12:42=E2=80=AFPM Yuntao Wang <ytcoode@gmail.com> wr=
ote:
>
> The original intention of acpi_parse_entries_array() is to return the
> number of all matching entries on success. This number may be greater tha=
n
> the value of the max_entries parameter. When this happens, the function
> will output a warning message, indicating that `count - max_entries`
> matching entries remain unprocessed and have been ignored.
>
> However, commit 4ceacd02f5a1 ("ACPI / table: Always count matched and
> successfully parsed entries") changed this logic to return the number of
> entries successfully processed by the handler. In this case, when the
> max_entries parameter is not zero, the number of entries successfully
> processed can never be greater than the value of max_entries. In other
> words, the expression `count > max_entries` will always evaluate to false=
.
> This means that the logic in the final if statement will never be execute=
d.
>
> Commit 99b0efd7c886 ("ACPI / tables: do not report the number of entries
> ignored by acpi_parse_entries()") mentioned this issue, but it tried to f=
ix
> it by removing part of the warning message. This is meaningless because t=
he
> pr_warn statement will never be executed in the first place.
>
> Commit 8726d4f44150 ("ACPI / tables: fix acpi_parse_entries_array() so it
> traverses all subtables") introduced an errs variable, which is intended =
to
> make acpi_parse_entries_array() always traverse all of the subtables,
> calling as many of the callbacks as possible. However, it seems that the
> commit does not achieve this goal. For example, when a handler returns an
> error, none of the handlers will be called again in the subsequent
> iterations. This result appears to be no different from before the change=
.
>
> This patch corrects and cleans up the logic of acpi_parse_entries_array()=
,
> making it return the number of all matching entries, rather than the numb=
er
> of entries successfully processed by handlers. Additionally, if an error
> occurs when executing a handler, the function will return -EINVAL immedia=
tely.
>
> This patch should not affect existing users of acpi_parse_entries_array()=
.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>

This needs to be ACKed by Dave Jiang or Dan Williams.

> ---
>  lib/fw_table.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/lib/fw_table.c b/lib/fw_table.c
> index b51f30a28e47..b655e6f4b647 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -85,11 +85,6 @@ acpi_get_subtable_type(char *id)
>         return ACPI_SUBTABLE_COMMON;
>  }
>
> -static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *pro=
c)
> -{
> -       return proc->handler || proc->handler_arg;
> -}
> -
>  static __init_or_acpilib int call_handler(struct acpi_subtable_proc *pro=
c,
>                                           union acpi_subtable_headers *hd=
r,
>                                           unsigned long end)
> @@ -133,7 +128,6 @@ acpi_parse_entries_array(char *id, unsigned long tabl=
e_size,
>         unsigned long table_end, subtable_len, entry_len;
>         struct acpi_subtable_entry entry;
>         int count =3D 0;
> -       int errs =3D 0;
>         int i;
>
>         table_end =3D (unsigned long)table_header + table_header->length;
> @@ -145,25 +139,19 @@ acpi_parse_entries_array(char *id, unsigned long ta=
ble_size,
>             ((unsigned long)table_header + table_size);
>         subtable_len =3D acpi_get_subtable_header_length(&entry);
>
> -       while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
> -               if (max_entries && count >=3D max_entries)
> -                       break;
> -
> +       while (((unsigned long)entry.hdr) + subtable_len < table_end) {
>                 for (i =3D 0; i < proc_num; i++) {
>                         if (acpi_get_entry_type(&entry) !=3D proc[i].id)
>                                 continue;
> -                       if (!has_handler(&proc[i]) ||
> -                           (!errs &&
> -                            call_handler(&proc[i], entry.hdr, table_end)=
)) {
> -                               errs++;
> -                               continue;
> -                       }
> +
> +                       if (!max_entries || count < max_entries)
> +                               if (call_handler(&proc[i], entry.hdr, tab=
le_end))
> +                                       return -EINVAL;
>
>                         proc[i].count++;
> +                       count++;
>                         break;
>                 }
> -               if (i !=3D proc_num)
> -                       count++;
>
>                 /*
>                  * If entry->length is 0, break from this loop to avoid
> @@ -180,9 +168,9 @@ acpi_parse_entries_array(char *id, unsigned long tabl=
e_size,
>         }
>
>         if (max_entries && count > max_entries) {
> -               pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
> -                       id, proc->id, count);
> +               pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n"=
,
> +                       id, proc->id, count - max_entries, count);
>         }
>
> -       return errs ? -EINVAL : count;
> +       return count;
>  }
> --

