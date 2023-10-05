Return-Path: <linux-acpi+bounces-436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E47B9CFC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7C4D91C2090A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 12:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9E9134C0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D2125CE
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 11:05:08 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD06323D20;
	Thu,  5 Oct 2023 04:05:06 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57de3096e25so174467eaf.1;
        Thu, 05 Oct 2023 04:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503903; x=1697108703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A+Fvcyy0CxxYZT2asQGYv+IG3i4az/fLQnzcd8QYxU=;
        b=VYScoWd491SLfWxMN1VGvJ2u6TGMZdVswXfMsBYpqcH7KnP4fP19rQ6KG6ZiSdHQ/p
         Dq+pv2s+Jhmc10A3f9FwxB7jwO1fHriu9gYbKFaQRHt/PVhwax+azLTUFVfGfbGLp5V8
         yBmWPiABQoZrDCmk2/V/r+T9MHAD0VpJHYpIK8+Q5ksEMJy5qWvU8Xdua/Efy0OEWn/M
         0NiyjYIoAQ7P6yzPW/z52tdAyPIExh3sqsuohpIm/jtg9ru6q8g0pJDNlR9c56qpaDXA
         mMmSM3w5qAAo5akTOkddY0W9ZxZ9PJ9aFNyE5ZVqS1s8qyhTdZ0tcCP0FGkmosNdkdvi
         Qdxw==
X-Gm-Message-State: AOJu0Yy9EThVfJWezSlXIFBmjcSKPyy/hdWg7b/uG+nnPkyq6alHtvjq
	oPIg9L1NKa4E+hMX2omjic8WCq5Qay5ol7mW0xs=
X-Google-Smtp-Source: AGHT+IEDQL53+ju6VUU2WVkO64QHb88QaJsba566ALMVEb5ykrLA0ijgHowjurBxevBOMNfVLxNTUISTkuaPKCzkAgs=
X-Received: by 2002:a4a:c509:0:b0:57e:c9bf:696e with SMTP id
 i9-20020a4ac509000000b0057ec9bf696emr4741772ooq.1.1696503903280; Thu, 05 Oct
 2023 04:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4846448.GXAFRqVoOG@kreacher> <8288399.T7Z3S40VBb@kreacher> <f14894b4-805c-3eb4-755c-4795405d7e7e@linaro.org>
In-Reply-To: <f14894b4-805c-3eb4-755c-4795405d7e7e@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Oct 2023 13:04:51 +0200
Message-ID: <CAJZ5v0j-K5bo1hoLEb1-PYx27cNfC36uWEF--pc41beFKCk=eg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: thermal: Combine passive and active trip
 update functions
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 6:30=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 03/10/2023 15:21, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Combine acpi_thermal_update_passive_trip() and
> > acpi_thermal_update_active_trip() into one common function called
> > acpi_thermal_update_trip(), so as to reduce code duplication and
> > prepare the code in question for subsequent changes.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for all of the reviews, much appreciated!

I'm going to apply the series now unless you have strong objections
against any of the remaining patches [4,6/6].

Cheers!

