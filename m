Return-Path: <linux-acpi+bounces-293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C686F7B3802
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 18:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 780E8284F20
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ABF3D983
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 16:32:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD05521C5
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 16:10:28 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9D195
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 09:10:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so5374885e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696003826; x=1696608626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsosfGEshqIoKCDorpEdcceOnoGA7Z3Gi/jf7+l6H3o=;
        b=T0+gcHKB+pVkYprBwVyFx8syY0qimTMhAUbYBsGdenN/tOAUS6K6V74Af28p0LiDy1
         RJs7V3hAORCTcBdANkJHpntEP7y6QgxnMOmo/eC4HJSptiAfzkarlxPir5aqXmhzxHwo
         kFDA45tT81w2cny+mS6LC3RGuni4iRqZU4zojIaxrGs8V7jm7eapAy9nRcxHPDCNhkjv
         lx5hT8bm9LsipNRyV/xD9ij74JAyrTzKKeeEOkBSuTRxEw3b5p9CtqduvdubEEtYTe/s
         BoA09oYqHSmpzwmYYyhwo1X6NuN6OAJu2+vbZ9dvgtctX6biNdFLfqbr8Vk1eKQ7s1/X
         IvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696003826; x=1696608626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsosfGEshqIoKCDorpEdcceOnoGA7Z3Gi/jf7+l6H3o=;
        b=g+3fhksxH9UAWFd3oii+EG4SVZ/pn8LJe+AnehHAmD18lO1bmhYy8OSW5HNUqn3H77
         hFR7xYeQ5M7f61yCCPtAiQRmsS7917WAJlkaLnW4vvoy3JnBKjqp6bJ5f90mi8Uga5zn
         +iFqTIW73aENJ7c+vfkT8sGovKMOVJMviN76XX03L3Yq8YQOSGn9GdsYYTZRvkdMLhvc
         3nAEDoqzK1tWs/PV9l2AYAe9KcvroMyLwkF/f+5H0mLttUlwnuQq440MaGvfd8BbT90A
         tusZFpFCyA736/NSAKLPmAcsUljkPA4iPwA24RUu0tbJnHT+d5dO+rqM+Dx7Gwtv1jhq
         Aecg==
X-Gm-Message-State: AOJu0YxYODQMEag2gC70/1JaHu3krA8ki34XUnDc9QOQny3LnBNxlYER
	vPSTZCPQTKh5qLoPwwKzZfFLvQaMFsEg1inzmDJz4w==
X-Google-Smtp-Source: AGHT+IGJVy4cn6wsfYJyybJLTpVzhBoLAsGq/mtGnVfwMtDc27EoHCRTJrLpDNvmF4nasPQGeqo5XBwkuq750bEZ3zY=
X-Received: by 2002:a05:6000:1090:b0:31f:f8a7:a26c with SMTP id
 y16-20020a056000109000b0031ff8a7a26cmr4058353wrw.25.1696003825641; Fri, 29
 Sep 2023 09:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com> <CAKwvOd=7vk2HKOpgVrRd2RtKSF9tXPqbVmN+5teLTNoBy4BWVg@mail.gmail.com>
In-Reply-To: <CAKwvOd=7vk2HKOpgVrRd2RtKSF9tXPqbVmN+5teLTNoBy4BWVg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 29 Sep 2023 09:10:11 -0700
Message-ID: <CAKwvOdkbcUh+tmsNcT4nCzFY37WbAUdjHJ62qNe=p8SetaQNTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Replace custom implementation of COUNT_ARGS()
To: "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, llvm@lists.linux.dev, 
	alsa-devel@alsa-project.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:50=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 20, 2023 at 8:38=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Replace custom and non-portable implementation of COUNT_ARGS().
> >
> > Fixes: e64b674bc9d7 ("software node: implement reference properties")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Closes: https://lore.kernel.org/r/ZQoILN6QCjzosCOs@google.com
>
> Thanks for the patch!
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1935
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Of course Linux would have a macro for this!  I should have known.
> Trying to wrap my head around it. Awesome

(resending as text/plain)

Can someone pick this up for linux-next?

CI for linux-next has been red for days over this.

>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/property.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 1684fca930f7..55c2692ffa8c 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -10,6 +10,7 @@
> >  #ifndef _LINUX_PROPERTY_H_
> >  #define _LINUX_PROPERTY_H_
> >
> > +#include <linux/args.h>
> >  #include <linux/bits.h>
> >  #include <linux/fwnode.h>
> >  #include <linux/stddef.h>
> > @@ -314,7 +315,7 @@ struct software_node_ref_args {
> >  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                    \
> >  (const struct software_node_ref_args) {                               =
 \
> >         .node =3D _ref_,                                          \
> > -       .nargs =3D ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1, \
> > +       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> >         .args =3D { __VA_ARGS__ },                                \
> >  }
> >
> > --
> > 2.40.0.1.gaa8946217a0b
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

