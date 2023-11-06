Return-Path: <linux-acpi+bounces-1277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3A7E2C12
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 19:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B07B20E33
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B38C12
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECD179B8
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 16:40:28 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862FD69;
	Mon,  6 Nov 2023 08:40:27 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-582050ce2d8so786093eaf.0;
        Mon, 06 Nov 2023 08:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699288827; x=1699893627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPIV7njENdtTLYGqIiMuh5zgPYOZ2BUnv8BTJaAa4sw=;
        b=sIhW2K17mPvlDBQNhrbocbYUZW6sOj0mpIDW67+S/28GUeaCyGYJOgJTtUMR6L1tsB
         gul1/rZdI8WoQb+Nib9rMP1cW3HzBUMR8C4k2Xg6yIHa16ABqpXNtLIUkde2A23JYVUR
         gIY0F/Ny9rUrkbal4BoaKDd1F6MOyHFxIw/l0+OkSDMoaWNyXu9nrZ8tyovkpjAVjsG3
         N0EjmOHLY73OoN5ngcU4T9ewPPQF5ZEdMB0xmiCyBhrjKObAnI42i25xPEAE6EHag4d1
         QCuoTC4DXbfgwcYoy1LS9/8MiDad4HinKm5GpS8mNayyJi1CW7F7LD2V2fIR0wVikqu/
         5s0Q==
X-Gm-Message-State: AOJu0YxBAt31RHoXR7qQG/vx69lMSR5OzDUjSIe74BA9tSAwp6qoEQhy
	Q/RVJY4teL76duaE9dD8tkLixFJ0D8eaz7ne6CU=
X-Google-Smtp-Source: AGHT+IEyfwHzUPeJZnVzXL+Ns9NOSQHsSPT6LPvODBhLKEmp64eJKWbGIKzyB43ZlkY1vH3xRTBmtWmKYXZdXt6Aq14=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr28730645oov.0.1699288827078; Mon, 06
 Nov 2023 08:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002195932.2501674-1-avadhut.naik@amd.com> <23f0b99b-9f14-4da8-954e-5d175aca1ab8@amd.com>
In-Reply-To: <23f0b99b-9f14-4da8-954e-5d175aca1ab8@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 17:40:16 +0100
Message-ID: <CAJZ5v0gM5owYgRxzjy_zFH1R8Fuk53W=LDhd33mB2U7j5=Ra0Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
To: Avadhut Naik <avadnaik@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com, 
	Avadhut Naik <avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 5:37=E2=80=AFPM Avadhut Naik <avadnaik@amd.com> wrot=
e:
>
> Hi,
>
> Any comments on this patch?

Please resend it with CCs to the designated reviewers for APEI, as per
MAINTAINERS.

Thanks!

