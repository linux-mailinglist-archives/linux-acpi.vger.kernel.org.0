Return-Path: <linux-acpi+bounces-709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B5F7CCE3F
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 22:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C9281901
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0082E3F4
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F42EAF7
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 19:19:44 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F5F9;
	Tue, 17 Oct 2023 12:19:42 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-581e106fd25so127545eaf.0;
        Tue, 17 Oct 2023 12:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570381; x=1698175181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7ieEvfyHQY7ULuaED1WrfSZ5wAczggZiEh44Iol3Mg=;
        b=V6RDkGVr1oElsuHIr2MuhX2JvF0c+/qhsqHaMRUDpNlFHVozAd0AiORTjnbmfpRnsk
         lQ0u5EdS2qnNJRAQ0/BaC28klJl0CfiHNgTnPM3yRgav7VeR17MOKEVjmOIKW6i1gCvm
         9Jfxv6ZNMwCzNcJPoRG2Hgq1Ix3b5E5VCjCrYzwYsMG6euFyv/L2BSey17C6mDUlekfx
         7FLFJZMYLVirxY+BejXGH3kwMlydiZNOOK3wZhkQjlQOz30RflU1hG6OSHTbM4Jm7ijc
         nlDzMe5UM/386nzMM0W8iyRl1Jertz42GbRRVwtfo1f3RDp/4QWE0u0+tPCeToaa8Rbi
         8BGA==
X-Gm-Message-State: AOJu0YwGoZH1+SIMJHJ35CmIdUnKRzfTX1PGHrWF3i4Kq2gwYbaNvF0X
	RGDxkCWD6HybumfsOa5tYlkpmzhVX1BDubDPCv4=
X-Google-Smtp-Source: AGHT+IH7Ib+IgBHBd8TNyJMhv0EEBE9C9qmkJPLadiqejEoD18ZONUozBNi5jP6C7gdY9ygf44U13Go+m7CqCGt9u2c=
X-Received: by 2002:a4a:e60d:0:b0:57b:7e31:c12 with SMTP id
 f13-20020a4ae60d000000b0057b7e310c12mr3522279oot.1.1697570381480; Tue, 17 Oct
 2023 12:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
 <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
 <20230809185944.1ae78e34@jic23-huawei> <ZNTlniWf8Ou9hHOT@smile.fi.intel.com> <20230828190101.50f70921@jic23-huawei>
In-Reply-To: <20230828190101.50f70921@jic23-huawei>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Oct 2023 21:19:30 +0200
Message-ID: <CAJZ5v0gOXsX98jQTRSwoYmfYBfva1RHTsDaLL++m7c+kLjStVA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] device property: Add fwnode_property_match_property_string()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Gerald Loacker <gerald.loacker@wolfvision.net>, Gwendal Grignou <gwendal@chromium.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 8:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 10 Aug 2023 16:26:54 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > On Wed, Aug 09, 2023 at 06:59:44PM +0100, Jonathan Cameron wrote:
> > > On Tue,  8 Aug 2023 19:27:56 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > ...
> >
> > > > +int fwnode_property_match_property_string(const struct fwnode_hand=
le *fwnode,
> > > > + const char *propname, const char * const *array, size_t n)
> > >
> > > Hi Andy,
> > >
> > > Whilst I'm not 100% sold on adding ever increasing complexity to what=
 we
> > > match, this one feels like a common enough thing to be worth providin=
g.
> >
> > Yep, that's why I considered it's good to add (and because of new comer=
s).
> >
> > > Looking at the usecases I wonder if it would be better to pass in
> > > an unsigned int *ret which is only updated on a match?
> >
> > So the question is here are we going to match (pun intended) the protot=
ype to
> > the device_property_match*() family of functions or to device_property_=
read_*()
> > one. If the latter, this has to be renamed, but then it probably will c=
ontradict
> > the semantics as we are _matching_ against something and not just _read=
ing_
> > something.
> >
> > That said, do you agree that current implementation is (slightly) bette=
r from
> > these aspects? Anyway, look at the below.
> >
> > > That way the common properties approach of not checking the return va=
lue
> > > if we have an optional property would apply.
> > >
> > > e.g. patch 3
> >
> > Only?
> I didn't look further :)
>
> >
> > > would end up with a block that looks like:
> > >
> > >     st->input_mode =3D ADMV1014_IQ_MODE;
> > >     device_property_match_property_string(&spi->dev, "adi,input-mode"=
,
> > >                                           input_mode_names,
> > >                                           ARRAY_SIZE(input_mode_names=
),
> > >                                           &st->input_mode);
> > >
> > > Only neat and tidy if the thing being optionally read into is an unsi=
gned int
> > > though (otherwise you still need a local variable)
> >
> > We also can have a hybrid variant, returning in both sides
> >
> >   int device_property_match_property_string(..., size_t *index)
> >   {
> >         if (index)
> >                 *index =3D ret;
> >         return ret;
> >   }
> >
> > (also note the correct return type as it has to match to @n).
> >
> > Would it be still okay or too over engineered?
> >
> Probably over engineered....
>
> Lets stick to what you have.  If various firmware folk are happy with
> the new function that's fine by me.  Rafael?

Sorry for the delay, I've lost track of this.

Honestly, I have no strong opinion, but I think that this is going to
reduce some code duplication which is a valid purpose, so please feel
free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to this patch.

Thanks!

