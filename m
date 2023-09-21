Return-Path: <linux-acpi+bounces-44-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E887AA040
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 22:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D73282058
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409719458
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 20:35:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5D168BD;
	Thu, 21 Sep 2023 18:58:14 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B49AD572;
	Thu, 21 Sep 2023 11:57:53 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57b48918efcso154359eaf.1;
        Thu, 21 Sep 2023 11:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322673; x=1695927473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f7ViRYfsWSal9C6aJL7znT5o1TqA7Blwp7+5qFkVgU=;
        b=kWmdIzks8HssDJfqQCWoNfJljo2zds//Efqh+HDGE95wBq+fB+0jM2F8DDq86PePeO
         Ddycw1MCICPc43bvyNv0cd5o8tWQGeXEMJY9glR9dFCHIzuiL9aG210HYb8YK3XLD86p
         GeRWLYiF+n2wGWgtxih+Uj1WILunGfEaC1zCIjjM/kBAUAIvziPJ499TEnrkHA8Stwot
         2Votz5+No6Nt1WI8uolZuDjXfrcNLcc21jZu8wtlo8sVcvR04S4gASrUOFNgfiQdza5z
         tsOSLkNipYuFonpuRgwSYzHC3WupU1rUyQosf9nCqKmWokCDByLbFndFmqO5nWx0nGmz
         ajTA==
X-Gm-Message-State: AOJu0YxAyTgzW8HpX6Y/yLv+apeGo0xE1cHu+gXQWU1xU7lgjz5dCaON
	67BMVYkK0AVSXR74+Sb8gmaGqOt6ADeEwCPmWNuwyeYY
X-Google-Smtp-Source: AGHT+IFqpcHK2E1NnTs8QIlCkkT47Mk/fgAlghzObtrad64gQjOynEX7q1/BZ45Ycj/i2OBWM72QWWVUFSEGA1AU6MU=
X-Received: by 2002:a4a:d103:0:b0:573:4a72:6ec with SMTP id
 k3-20020a4ad103000000b005734a7206ecmr6047235oor.1.1695322673042; Thu, 21 Sep
 2023 11:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911-strncpy-drivers-acpi-osi-c-v1-1-ca2ec0667b18@google.com> <202309142015.FC86A2C@keescook>
In-Reply-To: <202309142015.FC86A2C@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Sep 2023 20:57:42 +0200
Message-ID: <CAJZ5v0jbNX91hYdGaO4CgZOoLSfDaF9f3XGk1wWHA6ivV+Vjtw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: OSI: refactor deprecated strncpy
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 5:16=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Sep 11, 2023 at 08:36:44PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > We know `osi->string` is a NUL-terminated string due to its eventual us=
e
> > in `acpi_install_interface()` and `acpi_remove_interface()` which expec=
t
> > a `acpi_string` which has been specifically typedef'd as:
> > |  typedef char *acpi_string; /* Null terminated ASCII string */
> >
> > ... and which also has other string functions used on it like `strlen`.
> > Furthermore, padding is not needed in this instance either.
>
> Following the callers, I agree, this doesn't need %NUL padding -- it's
> always processed as a regular C string.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied as 6.7 material, thanks!

