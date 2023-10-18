Return-Path: <linux-acpi+bounces-717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F837CDBC5
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D14E281C8E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771234CD5
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04102171AE
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 10:39:58 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8CDB0;
	Wed, 18 Oct 2023 03:39:57 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57de3096e25so1371002eaf.1;
        Wed, 18 Oct 2023 03:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625597; x=1698230397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtmjII0ee1f21HN24SIPEYP9xZN9qMse1/pApzruflA=;
        b=PBNdeV+68fXXHjm1LL8loE6LLA0ek8xGQQaF+B0Hk51y83nm7lsIfsr3MOeBo2QOsQ
         wO35nMfKal3ekCiaDfSUqGnDx9enbWReIIwOX7Mus9zPDfnG2H+lj7kGsU3AjOtRuHEE
         6lgMsKkX/vkXVFh6eR6cIxZjc/EHSmgbNXp9EfdhgvBvTzckHbaMpGbjQHCiP8MintRr
         yqizyy9okeyCi4wUgV+3nk8W6YwXBqCECgj4lu/px6IjjiP9KMFS+3C1C4MDYs/JvwJE
         YdX1NrZfG/DocQucLxCrlUuQDpw8/rCO2s4C4MK8qJQZ5DXU6X2XsSM21QwZ2v5O+eAM
         F+1Q==
X-Gm-Message-State: AOJu0YzBZrT2JX+QuCUfoxpy/T8i6kuZFtDhzZrdvm+Ev+bvEs8WYosZ
	BuykQLpxTnr/5bJbywIHJTl2ZuHox4uBX7q2jRU=
X-Google-Smtp-Source: AGHT+IFqHTgrARdc0q1r9FIddruvQnjJjU8onYjV7cSScx6lMxZRYIE772ygaGjJZnfdXpHVmL5HSXSsnZZYxUACNuE=
X-Received: by 2002:a4a:4f15:0:b0:581:e7b8:dd77 with SMTP id
 c21-20020a4a4f15000000b00581e7b8dd77mr3387616oob.1.1697625597298; Wed, 18 Oct
 2023 03:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017082905.1673316-1-michal.wilczynski@intel.com> <652f5eddba760_5c0d29449@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <652f5eddba760_5c0d29449@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 12:39:46 +0200
Message-ID: <CAJZ5v0g5buHjd+EqMsHtuN2vcJHSTCd-cCchvo-44iPi1cKk5A@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: NFIT: Use cleanup.h helpers instead of devm_*()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Wilczynski <michal.wilczynski@intel.com>, nvdimm@lists.linux.dev, 
	linux-acpi@vger.kernel.org, rafael@kernel.org, vishal.l.verma@intel.com, 
	lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 6:28=E2=80=AFAM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Michal Wilczynski wrote:
> > The new cleanup.h facilities that arrived in v6.5-rc1 can replace the
> > the usage of devm semantics in acpi_nfit_init_interleave_set(). That
> > routine appears to only be using devm to avoid goto statements. The
> > new __free() annotation at variable declaration time can achieve the sa=
me
> > effect more efficiently.
> >
> > There is no end user visible side effects of this patch, I was
> > motivated to send this cleanup to practice using the new helpers.
> >
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > ---
> >
> > Dan, would you like me to give you credit for the changelog changes
> > with Co-developed-by tag ?
>
> Nope, this looks good to me, thanks for fixing it up.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Are you going to apply it too, or should I take it?

