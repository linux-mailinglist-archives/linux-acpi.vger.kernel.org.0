Return-Path: <linux-acpi+bounces-2184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1561807967
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A856F2821B0
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC5D48784
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED5D122;
	Wed,  6 Dec 2023 11:47:32 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fb2b83986cso34897fac.0;
        Wed, 06 Dec 2023 11:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892052; x=1702496852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Eye1pIVAzvd8vmh6Sf9HoBroJHBM9TBK6FZNnnZG10=;
        b=gaWEWd0w8/eDrKR4JQtRo8HKUbpPb+8W4YcS7t+8JjwTOoL+gkq3+L1H3sZk/Cl690
         TrURp9laYUua5tBqsDrv/vMNCQ0JalgX7Hq+4XgjuhBcZRxFII/5LyVgBz904SUYbzWO
         q5FyzB4Z6TN6wesZxzt+LqEM7dajL8a8lweL9oPD9ydvLE81rTklmIzC3hncbr+ltK8C
         3sY3eK3vvB03SMWsFgqn7BoszpZ/nd7vzBkDeXN+W8oO4a7W+hd+/7D5x7YqC9R9/yMm
         Y0g+L/XqPHePSfZx5DyNYfp7KtLheLoQqCOXDICC0YsWevu4VWdxaWvpKmfRJSZimXnj
         N4hQ==
X-Gm-Message-State: AOJu0YzC7T8rIu/9Zby0w0L2z8U2XYHB9ust3YFN9FNp9N40x9w+flb7
	dUNZBHLgUhU/EkqIOpWv2wXkivRDiBJ10D/5GRY=
X-Google-Smtp-Source: AGHT+IHo/L1CPdCP43tGzl06TrRk3U5YvZ+Z9eWKpqVkyvdNdAOdh9PH9K46tvxbm2gvrJFY/cDjEP/aDJy2zTpMhx0=
X-Received: by 2002:a05:6871:5d1:b0:1fb:30b8:bb5c with SMTP id
 v17-20020a05687105d100b001fb30b8bb5cmr2696263oan.3.1701892051808; Wed, 06 Dec
 2023 11:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120114143.95305-1-ytcoode@gmail.com> <CAJZ5v0ijJeOLJo=ooru9raj0n=iiGybFCud42Z+EEtncgNk47A@mail.gmail.com>
 <575e4395-dfe1-4399-9706-cc02f56d7ebe@intel.com>
In-Reply-To: <575e4395-dfe1-4399-9706-cc02f56d7ebe@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 20:47:20 +0100
Message-ID: <CAJZ5v0gRbPBij961wTgCzVZL3ie6ru4niQzYip8a9p64BaSKjQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Correct and clean up the logic of acpi_parse_entries_array()
To: Dave Jiang <dave.jiang@intel.com>, Yuntao Wang <ytcoode@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:02=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> wr=
ote:
>
>
>
> On 12/6/23 09:42, Rafael J. Wysocki wrote:
> > On Mon, Nov 20, 2023 at 12:42=E2=80=AFPM Yuntao Wang <ytcoode@gmail.com=
> wrote:
> >>
> >> The original intention of acpi_parse_entries_array() is to return the
> >> number of all matching entries on success. This number may be greater =
than
> >> the value of the max_entries parameter. When this happens, the functio=
n
> >> will output a warning message, indicating that `count - max_entries`
> >> matching entries remain unprocessed and have been ignored.
> >>
> >> However, commit 4ceacd02f5a1 ("ACPI / table: Always count matched and
> >> successfully parsed entries") changed this logic to return the number =
of
> >> entries successfully processed by the handler. In this case, when the
> >> max_entries parameter is not zero, the number of entries successfully
> >> processed can never be greater than the value of max_entries. In other
> >> words, the expression `count > max_entries` will always evaluate to fa=
lse.
> >> This means that the logic in the final if statement will never be exec=
uted.
> >>
> >> Commit 99b0efd7c886 ("ACPI / tables: do not report the number of entri=
es
> >> ignored by acpi_parse_entries()") mentioned this issue, but it tried t=
o fix
> >> it by removing part of the warning message. This is meaningless becaus=
e the
> >> pr_warn statement will never be executed in the first place.
> >>
> >> Commit 8726d4f44150 ("ACPI / tables: fix acpi_parse_entries_array() so=
 it
> >> traverses all subtables") introduced an errs variable, which is intend=
ed to
> >> make acpi_parse_entries_array() always traverse all of the subtables,
> >> calling as many of the callbacks as possible. However, it seems that t=
he
> >> commit does not achieve this goal. For example, when a handler returns=
 an
> >> error, none of the handlers will be called again in the subsequent
> >> iterations. This result appears to be no different from before the cha=
nge.
> >>
> >> This patch corrects and cleans up the logic of acpi_parse_entries_arra=
y(),
> >> making it return the number of all matching entries, rather than the n=
umber
> >> of entries successfully processed by handlers. Additionally, if an err=
or
> >> occurs when executing a handler, the function will return -EINVAL imme=
diately.
> >>
> >> This patch should not affect existing users of acpi_parse_entries_arra=
y().
> >>
> >> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> >
> > This needs to be ACKed by Dave Jiang or Dan Williams.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Applied as 6.8 material, thanks!

