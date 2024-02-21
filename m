Return-Path: <linux-acpi+bounces-3806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F885EBFD
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 23:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7AB240F9
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C212AAEB;
	Wed, 21 Feb 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4E9he3p9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5A12CD85
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555722; cv=none; b=bCxcDYsSdT7/EkqSbG1DY+6vhlyr6oZNp14yHZbHeGNp7NerJRDMi8zLKGIbjzdb7VEfh6u5J9cMN0oM09vSwctDSviADgJBZuMZ3iUIqYyZZ4vcTV06Ua+PNHUzXVcju86qZ92AXpA7d+xMfodKIorrJi/9vN/ucCvMeq+/WPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555722; c=relaxed/simple;
	bh=1CkGcXdG+KrlM+x9gWekq+WBiUkt/eToiyx5uT4ML+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrZEOVFVHRtY44ZM0jV85Vfb0uHzgiDQ7JcRspjE9C+zSS3NRiAT0jrw96xsX6e3U6bXZTevctfxwdMl2tcDuW6gJQiNF6BjrjRNrLWLG1+wKJkf+8zOrbLk9Es2rf00pfe3Ry1YmVkwL/tDncWfvi8TMMROfc2vWHA/0HWdtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4E9he3p9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e0b1b11bbso24081cf.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 14:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708555684; x=1709160484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw5fc5I26kdjc0zlKV7SIy+DOj8voXJyqY3HQnL2RuU=;
        b=4E9he3p9Gt5DJ4bz0VKbMtIezXkJVB1PMFthc06+xcYvzk2p8jeO8bCiTaEqPCnlJC
         TJSmMaQGZoTEoGcZUCib8edHI60UA6zfh0Ccww0hUFNo/eN581y2yd+zhd2XCShqN5MD
         gXfdUgtQOq1SzQiceBbALEFyPAnoCoOe8zcwqCYX4cS3KvVF6rrZOA770g36Y4XuajH3
         3jU1rCkLgNbe5tIj8Q6dL0A07OcHM1vQMLV+rwNIXDv0n1CzjvS7G/GALHLtIis+AEpN
         Yr8LA+ASYHUapVw3SJeZuw2+fPbD8KckiatUIrA5/XdUAkGgj0gCLwZEP0PDGUYTEtrl
         a9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708555684; x=1709160484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw5fc5I26kdjc0zlKV7SIy+DOj8voXJyqY3HQnL2RuU=;
        b=VY+Fi8Q3MLViJu+3YqTo8qQEp8a4nmFL676fsT5NtH2Eu5Fn9NpE2Zuxl+m+g5BqmK
         EEWwlGat6Dlsmhj5PgPh9qdhlyZcMRePQHSak6TDCeYl86qS8P4iT8a236mYDAzJ7npq
         C+eqiMVdmGuvBmTOcKmQAbLzvHWvNtjshjg+ootP912sBmBZ3uEpMpzo0zTXZniAatI2
         MfHfz0LnkWIMtrT1JyXwsbo83liMcPCU3IjnQ3SfG2RfG0ADQe+UkztuFD+AbO5nHzw2
         kqI2clFAaeapgGS++5xp9ukl+br0XpHJpQYQ5EJuI/IFq/Ne6kBjdspeFEZdNpLTSuMN
         eB8g==
X-Forwarded-Encrypted: i=1; AJvYcCVO2wHAlzaO9vFlW+4n7ZzzjOn6XdLZakc8vWRBHC/6QcTKO/oecUud/7uJvoAuJvuft1dMZ5jsaBS+W2gYTykZiqEP14sXNZcjKw==
X-Gm-Message-State: AOJu0YzCB49UA21uFKsB2OY8yXJ9sZyiX/xezpFOEoSmWD/79TsMnkiM
	0rLEF+pGS67SHkP64LUrgQfz7kFR3BAmpBzmxFxlSvQMjr77WP2pK40o6rxRkYqw8jAnrcw8zpq
	nzbGtOzV4Lm9LAB8XINMXsZkhdaKiWKWHpiNS
X-Google-Smtp-Source: AGHT+IHIiztHrlPVGbWlf9kC0Qn60zcxekXTmFXaa6Zvf6bxngg4By83+kUKNWAWtpmAT3Koc+UzgsGYRi3muOBgwgE=
X-Received: by 2002:ac8:1242:0:b0:42d:dbd8:e12 with SMTP id
 g2-20020ac81242000000b0042ddbd80e12mr441467qtj.2.1708555683602; Wed, 21 Feb
 2024 14:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com> <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud> <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
 <20240215-unstirred-rearrange-d619a2524a63@spud> <CAGETcx8EBta8dUSELUJ6_ibZABnnhSYX0VEGa8s-CbHFYuskkQ@mail.gmail.com>
 <20240221-emblaze-ripeness-7ad4e41343fa@spud>
In-Reply-To: <20240221-emblaze-ripeness-7ad4e41343fa@spud>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 21 Feb 2024 14:47:26 -0800
Message-ID: <CAGETcx99Dob1D6Cr7+wN5+4aARgBdGdwEkNUjRAc6d_Ls9dqrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:34=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Feb 20, 2024 at 08:13:31PM -0800, Saravana Kannan wrote:
> > I made that fix and now I'm getting this:
> > $ make DT_CHECKER_FLAGS=3D-m dt_binding_check
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/post-init-suppliers=
.yaml
> >   DTEX    Documentation/devicetree/bindings/post-init-suppliers.example=
.dts
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-sup=
pliers.yaml:
> > 'oneOf' conditional failed, one must be fixed:
> >         'unevaluatedProperties' is a required property
> >         'additionalProperties' is a required property
> >         hint: Either unevaluatedProperties or additionalProperties
> > must be present
> >         from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/tpm/ibm,vtpm.=
yaml:
> > ignoring, error in schema: properties
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-sup=
pliers.yaml:
> > ignoring, error in schema:
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/soc/tegra/nvi=
dia,tegra20-pmc.yaml:
> > ignoring, error in schema: allOf: 0: then: properties: pinmux
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/net/lantiq,pe=
f2256.yaml:
> > ignoring, error in schema: properties: lantiq,data-rate-bps
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-sup=
plier.yaml:
> > ignoring, error in schema:
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/=
honeywell,mprls0025pa.yaml:
> > ignoring, error in schema: properties: honeywell,pmax-pascal
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/=
honeywell,hsc030pa.yaml:
> > ignoring, error in schema: properties: honeywell,pmax-pascal
>
> >   DTC_CHK Documentation/devicetree/bindings/post-init-suppliers.example=
.dtb
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@1000: failed to match any schema with
> > compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@1000: failed to match any schema with
> > compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@2000: failed to match any schema with
> > compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@2000: failed to match any schema with
> > compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
>
> FWIW, I don't see these or the other errors you see above. You really
> need to get yourself a newer version of dt-schema, or else avoid
> working on this using whatever castrated system google provides you with!

Ok, finally found the workaround to updating these packages and the
output is a lot cleaner now.

> > But I guess the "oneOf" error is because the yaml is being treated as
> > a description of a DT node and not a schema?
>
> The oneOf is due to missing "additionalProperties: true" - As far as I
> understand you need that regardless of whether this is going into
> dt-schema or the kernel.

Ok, I added that and the errors go away. I'll send out a v3 and
hopefully Rob can pick it up.

-Saravana

