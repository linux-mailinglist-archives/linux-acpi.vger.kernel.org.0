Return-Path: <linux-acpi+bounces-494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBF7BC066
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7187A1C2083B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CCD44462
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DF38F90
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 19:35:37 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595A83;
	Fri,  6 Oct 2023 12:35:36 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57c0775d4fcso330053eaf.0;
        Fri, 06 Oct 2023 12:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696620936; x=1697225736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKAwecnvkxtRCGWDeS12LsGl0fw9bBw14Ff9x7XqtoI=;
        b=ULCNJ5vj9FM0+L6g6EJvFHAf+gSAZm3bbkLlc+FuT1sjlOCJ/dR7u8hsAsb8K8cCuz
         SYQZrV2hOkPh3ARhdfpRP/Wu7qRKsPHnkaVIVJY9ckwrDt7EUO1MOQkvW+J04ebh535k
         ORAv1LZjMPBviON7FXpyoReb3l+TX07h8ER/mOPJhK7hfkLKGo+Oa/16DqKccBZ9nEOS
         SAqXpphfIlAr3YsoCu//ESi6a7/7uYIprtd8CLRSl0uB8k/3mJLxNl9avrwDQ9qIYWto
         0f1WafoHA1GLGynuRFNtP5bFrsvXUV78sFABQDx5C4e1e2F+p6A9mgWsMUU8yxO8tpvi
         kWRg==
X-Gm-Message-State: AOJu0YzqmBJZpP6QNJf8lMxuBo0jCV7ItrYKJsT210u8GgIfLvhWMFvl
	W9EmpU4CZLb/4ApVC89nDDzxdn2PTohnoO6AlUI=
X-Google-Smtp-Source: AGHT+IFgWzAS1RXH4hZZBq/nk+53XC8N4cJO2GHDOSy0HSJpD6bW7gkkIPU0hdImEU+PnuBh40nIQn3vKFh3651iNn0=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr8847250oot.0.1696620936084; Fri, 06 Oct
 2023 12:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006130418.659320-1-sudeep.holla@arm.com>
In-Reply-To: <20231006130418.659320-1-sudeep.holla@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Oct 2023 21:35:25 +0200
Message-ID: <CAJZ5v0i-aHT+Uu6XvJrLb6ZoUBQ4rp4WJxiLOAtMSWH-KcdgMA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI: PCC: Updates for v6.7
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sudeep,

On Fri, Oct 6, 2023 at 4:36=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> Hi Rafael,
>
> I2C, HWMON and Hisilicon SoC changes are all acked-by respective maintain=
ers.
> All the changes are in the linux-next for some time now. Please pull!

Pulled, thanks!


> -->8
>
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d=
1d:
>
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git ta=
gs/acpi-pcc-updates-6.7
>
> for you to fetch changes up to a46e42c097982e258f89c64c5f52f30994bcfeda:
>
>   soc: kunpeng_hccs: Migrate to use generic PCC shmem related macros (202=
3-09-29 11:55:37 +0100)
>
> ----------------------------------------------------------------
> ACPI: PCC: Mailbox and generic updates for v6.7
>
> Main updates include:
> 1. Addition of support for Type 4 PCC subspace that enables platform
>    notification handling (Huisong Li).
> 2. Support for the shared interrupt amongst multiple PCC subspaces/
>    channels (Huisong Li).
> 3. Consolidation of PCC shared memory region command and status
>    bitfields definitions that were duplicated and scattered across
>    multiple PCC client drivers (Sudeep Holla).
>
> ----------------------------------------------------------------
> Huisong Li (2):
>       mailbox: pcc: Add support for platform notification handling
>       mailbox: pcc: Support shared interrupt for multiple subspaces
>
> Sudeep Holla (4):
>       ACPI: PCC: Add PCC shared memory region command and status bitfield=
s
>       i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
>       hwmon: (xgene) Migrate to use generic PCC shmem related macros
>       soc: kunpeng_hccs: Migrate to use generic PCC shmem related macros
>
>  drivers/hwmon/xgene-hwmon.c            | 16 ++----
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 16 ++----
>  drivers/mailbox/pcc.c                  | 91 ++++++++++++++++++++++++++++=
++----
>  drivers/soc/hisilicon/kunpeng_hccs.c   |  8 +--
>  include/acpi/pcc.h                     | 13 +++++
>  5 files changed, 104 insertions(+), 40 deletions(-)
>

