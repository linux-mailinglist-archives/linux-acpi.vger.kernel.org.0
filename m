Return-Path: <linux-acpi+bounces-692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B77CC35E
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 14:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0371C209E6
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C342BF2
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1784176F
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 10:56:14 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49979D41;
	Tue, 17 Oct 2023 03:56:09 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57de3096e25so1150694eaf.1;
        Tue, 17 Oct 2023 03:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697540166; x=1698144966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R8cNjbejuukXKtHRF4WxJOF67p0UWK9QqgSbWSP+S4=;
        b=evyb7TrnoIvToi7xe3I2aPbaNS9JqZNccod9C9jJ5m7OOfB4bRB7j7CaQ0qrM/4E1D
         FuN0shSbmPWdZA6J0HXrjy+BHJugRnb+kj7mo/rs/Jp0J7o+fPU5mbCzwbhsY96OuuxC
         N6J9M2CSUM4lwCeVWoelLCN7pYnViG//b8xu8E1KSx97H/TPblC38THT5fV8u4QOB9Ik
         TC+tHR6lWsRPdLSAui0VIBsqIA1R41X7KLKhjPqIxrvGGMgI8QnRx8pLWNvnMFC/FDsu
         Z2eUz8mGPzGsU6f/XJSl83PRo/pUoCrS6ffxWNMvpaQDlawvkFijMQ0wfM3UZbw3kquX
         T26g==
X-Gm-Message-State: AOJu0Yzg0nH2Ex0ne+QmGw8aCGlGS+KS2CBOIZwf9BBOgzekTiwWd1L+
	u+vgkCrso+sYrxQqh2rpm9oZeb6MXrGlAunpwH56t8EM
X-Google-Smtp-Source: AGHT+IEfBzk6kHctuvtvEO6iaHmDTVyNkDdlSP5TpEAs5YPycEgAbsuHo3Cv5HznZ/vS26o/uxbqzusJyj7c1EZWsy4=
X-Received: by 2002:a4a:ee94:0:b0:581:5990:dbb8 with SMTP id
 dk20-20020a4aee94000000b005815990dbb8mr1758159oob.0.1697540166076; Tue, 17
 Oct 2023 03:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-6-michal.wilczynski@intel.com> <e651d5e5-50a9-4884-8263-ce9d0d705b52@intel.com>
In-Reply-To: <e651d5e5-50a9-4884-8263-ce9d0d705b52@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Oct 2023 12:55:55 +0200
Message-ID: <CAJZ5v0gTUNV4vSF7RxQf9XB8gfOSwOX=+pg7jZVw_yTYbRdp5Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: NFIT: Replace acpi_driver with platform_driver
To: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, "Williams, Dan J" <dan.j.williams@intel.com>, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com, lenb@kernel.org, 
	vishal.l.verma@intel.com, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 12:45=E2=80=AFPM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
> On 10/6/2023 7:30 PM, Michal Wilczynski wrote:
> > NFIT driver uses struct acpi_driver incorrectly to register itself.
> > This is wrong as the instances of the ACPI devices are not meant
> > to be literal devices, they're supposed to describe ACPI entry of a
> > particular device.
> >
> > Use platform_driver instead of acpi_driver. In relevant places call
> > platform devices instances pdev to make a distinction with ACPI
> > devices instances.
> >
> > NFIT driver uses devm_*() family of functions extensively. This change
> > has no impact on correct functioning of the whole devm_*() family of
> > functions, since the lifecycle of the device stays the same. It is stil=
l
> > being created during the enumeration, and destroyed on platform device
> > removal.
> >
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>
> Hi Dan,
> Rafael already reviewed this patch series and merged patches
> that he likes. We're waiting on your input regarding two NFIT
> commits in this series.

I actually haven't looked at the NFIT patches in this series myself
and this is not urgent at all IMV.

Thanks!

