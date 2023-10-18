Return-Path: <linux-acpi+bounces-725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48B7CDBEB
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712191C209CF
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407135885
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B215AFE
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 11:30:21 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D3FE
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 04:30:20 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bc9353be9bso1336218a34.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628620; x=1698233420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzqlTkwXFjAGULurKjegAoRjGzDhhvRUJUE+mx+HM5Y=;
        b=YRR9gRm8E2vp2UhBoUc9sXXt+L2Zfkozh2O2G60JRhMonuYLhs9ryWJK5uXUn2cnL1
         zEZLKvCqZwDZogBxGlheyQGE+QP1UZEKzPeoULvAVA05jWa2mU6USpnNXcSU4yGeWwep
         I37PyCC9YLIknWZBEb5p8/5ZsDMJp7zJgIBAhH1WLcP/d/MaAR39ihsSGfzftgcalqdZ
         18lmxK5nu1ZIx/AQXnyfgdcROdjOYETCELq1yYPvKy4Rs8ANYA2yXuyFQg3gIS0FMJ+Q
         N/09Z4/4X+2fuEWzAz72HCdRQ1WYyZo+nr/ULg/iOBpinDVmbtq5q5Bq6AjaG119Lag4
         plAw==
X-Gm-Message-State: AOJu0Yx8XT/JlKQnuqsOmDUKCmE58aPLJY+CcqPqDSLsQ/5VIoinyl/x
	gBHrmq1FC+aQKVBmqdDRXjsRSO710INNIAAWj30=
X-Google-Smtp-Source: AGHT+IEsn4uL7a3/geAz4KLrwCd8+kMLJ0d8Jj1PikeON54sO2jSOSumY1QsBkwsKqi5LxR9HNzuOruHFi821s3O1nI=
X-Received: by 2002:a05:6820:180f:b0:581:f17d:5eb5 with SMTP id
 bn15-20020a056820180f00b00581f17d5eb5mr2210144oob.0.1697628620153; Wed, 18
 Oct 2023 04:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010082123.4167603-1-guohanjun@huawei.com> <864jiyqrey.fsf@scott-ph-mail.amperecomputing.com>
In-Reply-To: <864jiyqrey.fsf@scott-ph-mail.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 13:30:09 +0200
Message-ID: <CAJZ5v0hPtn_c=hgMDmYJv_GxTJan8heFJQoyN92UQe4_Nok0vg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: Move acpi_arm_init() to the place of after acpi_ghes_init()
To: D Scott Phillips <scott@os.amperecomputing.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 8:11=E2=80=AFPM D Scott Phillips
<scott@os.amperecomputing.com> wrote:
>
> Hanjun Guo <guohanjun@huawei.com> writes:
>
> > acpi_agdi_init() in acpi_arm_init() will register a SDEI event, so
> > it needs the SDEI subsystem to be initialized (which is done in
> > acpi_ghes_init()) before the AGDI driver probing.
> >
> > In commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
> > initialisation into acpi_arm_init()"), the acpi_agdi_init() was
> > called before acpi_ghes_init() and it causes following failure:
> >
> > | [    0.515864] sdei: Failed to create event 1073741825: -5
> > | [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741=
825
> > | [    0.515867] agdi: probe of agdi.0 failed with error -5
> > | ...
> > | [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.
> >
> > Fix it by moving acpi_arm_init() to the place of after
> > acpi_ghes_init().
> >
> > Fixes: fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific initialis=
ation into acpi_arm_init()")
> > Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>
> Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
>
> Thanks Hanjun and Sudeep

Applied as 6.6-rc material, thanks!

