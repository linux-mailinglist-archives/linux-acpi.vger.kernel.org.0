Return-Path: <linux-acpi+bounces-1698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288D7F313F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4F0B216A2
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F751C2E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B210DB;
	Tue, 21 Nov 2023 06:13:27 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d31666d89cso860816a34.1;
        Tue, 21 Nov 2023 06:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576007; x=1701180807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLbXOVCOe8I9i74gRQ9M4a7DNGH8GboOO++V6GgCwbg=;
        b=k+6QVqUN7HjVevNjxhI9s9eUHkDR9CBbxIBq0t6kgr3Q34nNHhpKQ3svlfkL6XD50d
         N7yZYiED1v8i1xdInC1fpTGlZZWi7TuHRilEFM4i/fV4h4m4XY5Fm09Xr3EPKGK7zo1j
         OxqRYiHE3706vCfS4pEuJl8ZDeUc0mA5/cc6RrHPrN70FQSsnsTb+zkEsgHgwaZAvPug
         vT6ewn7K+uVvuYz7J+ZeOkOI1BbhuM5U2G79ExP6Ocp+4Q7DeGE7R2jaNU9Pmli5uB8+
         3JVzYHvluXLRRFNIXwl71PNG0dp3AEvqpvDIFpxuo02s03xQ7q5mgK5w4WPg5JlpI4Az
         N3Bw==
X-Gm-Message-State: AOJu0Yy+xHU4MVvf9wSCTDvV/G+pU4xma33LkjYu6Q/yzpUnPH2q9Soo
	g1skojBbWE2i6YF/PP3M8MQThKumq8JUZt/U6/wI/JfA
X-Google-Smtp-Source: AGHT+IHgx6g+rJKOcCkESy4ug8DTJ8F31cIDaD+ZrrB5NezRtOLqENCOINUQU1xJDQAKNRJgK3KuYy8BDPz6c+am2Jo=
X-Received: by 2002:a4a:d44c:0:b0:584:1080:f0a5 with SMTP id
 p12-20020a4ad44c000000b005841080f0a5mr9931337oos.1.1700576007055; Tue, 21 Nov
 2023 06:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121070826.1637628-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20231121070826.1637628-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 15:13:16 +0100
Message-ID: <CAJZ5v0jgxVR9t604tC6LNOoD5Pv9vyhZNx=LiAcr4OR_C4_PcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Fix an error print in DisCo for Imaging support
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 9:33=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> The recently merged DisCo for Imaging support used a wrong printk
> specifier in printing a message. Fix it by using %zu instead of %lu.
> Also use "bits" instead of "bytes" as these are indeed bytes.
>
> Fixes: a6cb0a611273 ("ACPI: scan: Extract MIPI DisCo for Imaging data int=
o swnodes")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/mipi-disco-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.=
c
> index cad72d1fc127..7286cf4579bc 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -533,7 +533,7 @@ static void init_csi2_port(struct acpi_device *adev,
>         if (ret < 0) {
>                 acpi_handle_debug(handle, "Lane polarity bytes missing\n"=
);
>         } else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
> -               acpi_handle_info(handle, "Too few lane polarity bytes (%l=
u vs. %d)\n",
> +               acpi_handle_info(handle, "Too few lane polarity bits (%zu=
 vs. %d)\n",
>                                  ret * BITS_PER_TYPE(u8), num_lanes + 1);
>         } else {
>                 unsigned long mask =3D 0;
> --

Applied (with a slightly adjusted subject), thanks!

