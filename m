Return-Path: <linux-acpi+bounces-203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F73F7B06F1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B47962826F0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D326450CA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492730FB6
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:19:35 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996511B5;
	Wed, 27 Sep 2023 07:19:33 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57bc11c197aso802730eaf.1;
        Wed, 27 Sep 2023 07:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824373; x=1696429173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fsMC5H4Z8qtaB2lZAxAGWhZ2+lXG0cqJH9ZgXG/PH0=;
        b=G/x1RPR9etQ5jaonQ1laEbunSCSRJpO5xKuw6DnKXuNZRIz1wp5GLbbQ7C7+CiifXq
         ZifGi/LrGbkqQoa9ZOVbHdC3CHqt7dsnzP8cZ6mFdbo3BnNOqtulEtV0+0Qwa/gqFtyk
         pBrurbz1p70BjZRHxAbvckK4VmBZojdYsML6rc0sOyfrTqZ1kjtF5R+pkYPCy4v0QyOP
         Ses/1QKanfpr6L2pVA1D5qJSuXdI1yKVbmmmYT2q9gQAfDzc2F6mH1wlFBIm0Za/UnAx
         jIOevQ38dTSk7EGqPDwAS1JKbfe218wU7jmReKv16DjH1K21zpDylet6U5GyqChZd+js
         GFKQ==
X-Gm-Message-State: AOJu0Yyd7RCCrOPKe2Iw+nNKJOG33On8zoqIepGBlsI36FNkXRDrd6lu
	1NR45JGBzUi2Tqe2VEVz+0ZhuGU2W7Zev1iCs/I=
X-Google-Smtp-Source: AGHT+IE5D4KvhPI0G7z3IXWIl6DYNM1UWdx6BFCNnLTAFwRLK84+vP7K7lu49bAFkOV3tFG8TuU/avsHeWrkR+yMSU8=
X-Received: by 2002:a4a:ee18:0:b0:56e:94ed:c098 with SMTP id
 bd24-20020a4aee18000000b0056e94edc098mr2682527oob.0.1695824372783; Wed, 27
 Sep 2023 07:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
In-Reply-To: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Sep 2023 16:19:21 +0200
Message-ID: <CAJZ5v0hq37x_v6Z0Vqj2h8D5QZM8zWE4=GfrMk7YAEfUjeRydA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: PCC: Define and use the common PCC shared
 memory regions related macros
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 2:33=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> This set of 3 small patches intend to consolidate and replace the existin=
g
> locally defined macros within couple of PCC client drivers when accessing
> the command and status bitfields.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Sudeep Holla (3):
>       ACPI: PCC: Add PCC shared memory region command and status bitfield=
s
>       i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
>       hwmon: (xgene) Migrate to use generic PCC shmem related macros
>
>  drivers/hwmon/xgene-hwmon.c            | 16 +++++-----------
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 16 ++++------------
>  include/acpi/pcc.h                     | 11 +++++++++++
>  3 files changed, 20 insertions(+), 23 deletions(-)
> ---

This is fine with me.

How do you want to route it?

