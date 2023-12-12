Return-Path: <linux-acpi+bounces-2328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344280F6C7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 20:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CA41C20A33
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDCC81E57;
	Tue, 12 Dec 2023 19:38:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722FBA1;
	Tue, 12 Dec 2023 11:38:00 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5908b15f43eso480655eaf.1;
        Tue, 12 Dec 2023 11:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409880; x=1703014680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6TjCFcD7qqsRK8I7srUQGOuOzdomezjScNXBNfHm3c=;
        b=CriFQhx5hk5W2tseS+MUQG7YSyBpLDiMlDX/E1QASIDxaKmuTLtWhw1u8LxnBkX35i
         eGM0ijNr2paMNz8bORQ84gHzmJ1Pkcr/pUJnHAkroMuol4NslaEn2qOkKXN2vacNi+o4
         arNL4VqeBFuSFKWjpAtG9dFfpLjcm6TpBATpqWNaA5qUujQbQ4g7ifRpfGXhf6NYofTC
         +ilPXIEaMLj9aV1fBrdDR+La+ZzClbqHP7Pba5dH6mjPKGk4Y8W8+UO7EuTFLZp/0CDQ
         80vDdzwdFLTgDHDjj/2OmnLKt3Gl781UNR0usdhy3gBdIz0uxA437bP5VwpTYYFxdWRF
         4FIw==
X-Gm-Message-State: AOJu0YzfBpMZ2GMCi5qdiOZRDTrQD5trpU6+5tvpt+K4xRKEEkKcKB72
	odWo4WEh7qUyYOhWXRx6lSVl2atM8bxjyi6Kqv7A5e0u
X-Google-Smtp-Source: AGHT+IHUeZ5IA6EI9od+HcRjK7eilawttVi9sYNw6E2NHqGjYEiKVBQT4v0dg1zTZkhRiOEKPeNkOLpWPWsZu0OWTCE=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr13895661oob.1.1702409879802; Tue, 12
 Dec 2023 11:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206104318.182759-1-ytcoode@gmail.com>
In-Reply-To: <20231206104318.182759-1-ytcoode@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 20:37:48 +0100
Message-ID: <CAJZ5v0gUO-mz2=nN_Xz7ngw0hms1CziDMAKBv=xndqZtHd44UQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI/NUMA: A few fixes and cleanups in drivers/acpi/numa/srat.c
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 11:44=E2=80=AFAM Yuntao Wang <ytcoode@gmail.com> wro=
te:
>
> This series fixes an issue and does some cleanups in drivers/acpi/numa/sr=
at.c.
>
> Yuntao Wang (3):
>   ACPI/NUMA: Remove unnecessary check in acpi_parse_gi_affinity()
>   ACPI/NUMA: Optimize the check for the availability of node values
>   ACPI/NUMA: Fix the logic of getting the fake_pxm value

All patches applied as 6.8 material with some edits in the changelogs.

Thanks!

