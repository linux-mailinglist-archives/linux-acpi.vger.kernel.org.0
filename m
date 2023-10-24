Return-Path: <linux-acpi+bounces-888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6F77D5439
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2726F1C20503
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B942328A0
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FD36AF3;
	Tue, 24 Oct 2023 14:33:02 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432B8F;
	Tue, 24 Oct 2023 07:33:00 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e9e4636ce6so816616fac.0;
        Tue, 24 Oct 2023 07:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157980; x=1698762780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbg6/Pf1XWF9qiAo/Bp62JB8vPkBgG8ganuOuh0wuf8=;
        b=tzs9spvNuWbWclMrStZfrCtlFW6hponatDdM9HBAVCNzkEHPozhznVlKu4ewiDiHI/
         5AhIhQzTp3fnckFdEi1Q++Njc+xm9ddHWjDV96NPkSG6cFomkXVvMoVVkjXyTSdRXwKQ
         RmLn0yR8fGLjVgkYpvJo0Sfj6YlOvHVuPsWbqdtmG+kxjTJA2DrCd+ucc+oYTeXsZjjQ
         0Tj/4KlTFkwV5UFdKF7EuL8oK344NQEQGmr+wJ3/KjvwGOxQEnULcQZGd8Aa4Iok6sKw
         /zyfr8jkeFWs/FqWdqpZu6rpqPmAwSilgeTok0s5kUSjUo7rw/dz8vtdyhP/0vcT3xQ0
         eLRQ==
X-Gm-Message-State: AOJu0YxOfoNxF+PZ1azdXgX1ZB8FyGVvj+iepm3ha6QNzEASZaFolZi9
	a8dclehjiRysD76e/aB4hlZFJD8az0uxqPsx3E0TpVx0
X-Google-Smtp-Source: AGHT+IGxdYwV+5t593nxdBm55S75OJLko9wE0PsBu2QC9lWamPymlRTCxskxQktjdzG3dQGMeihta+/uXq2E5VLwAw8=
X-Received: by 2002:a05:6871:220e:b0:1e9:adec:bf5e with SMTP id
 sc14-20020a056871220e00b001e9adecbf5emr12630628oab.2.1698157979897; Tue, 24
 Oct 2023 07:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712223448.145079-1-jeshuas@nvidia.com> <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 16:32:48 +0200
Message-ID: <CAJZ5v0g2TsBo4hxsJBo5a-ggD2Cj65VS=tokpoRaNwzWbPoeNw@mail.gmail.com>
Subject: Re: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
To: Jeshua Smith <jeshuas@nvidia.com>, "Luck, Tony" <tony.luck@intel.com>, 
	"james.morse@arm.com" <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "gpiccoli@igalia.com" <gpiccoli@igalia.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 5:45=E2=80=AFPM Jeshua Smith <jeshuas@nvidia.com> w=
rote:
>
> Can we get this merged please, or at least instructions for what needs to=
 happen to get it merged?

So there are 3 designated reviewers for APEI: Tony Luck, Borislav
Petkov and James Morse.  I need an ACK or Reviewed-by from one of
them, so I can proceed with an APEI patch.

Thanks!

> -----Original Message-----
> From: Jeshua Smith
> Sent: Monday, October 2, 2023 10:10 AM
> To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@iga=
lia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8=
.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-harde=
ning@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@=
nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> Resending due to lack of responses.
>
> -----Original Message-----
> From: Jeshua Smith
> Sent: Monday, September 11, 2023 10:16 AM
> To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@iga=
lia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8=
.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-harde=
ning@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@=
nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> Any further questions? Anything else holding up this patch?
>
> -----Original Message-----
> From: Jeshua Smith <jeshuas@nvidia.com>
> Sent: Friday, August 4, 2023 7:05 PM
> To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@iga=
lia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8=
.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-harde=
ning@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@=
nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> Thanks for the reply.
>
> It's not very easy to see. It's just a bit down from the link you sent. I=
t's the last possible action in the Serialization Actions table:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#seriali=
zation-actions
>
> 18.5.1.1. Serialization Actions
>
> GET_EXECUTE-_OPERATION_TIMINGS
>
> Returns an encoded QWORD:
> [63:32] value in microseconds that the platform expects would be the maxi=
mum amount of time it will take to process and complete an EXECUTE_OPERATIO=
N.
> [31:0] value in microseconds that the platform expects would be the nomin=
al amount of time it will take to process and complete an EXECUTE_OPERATION=
.
>
> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Friday, August 4, 2023 10:31 AM
> To: Jeshua Smith <jeshuas@nvidia.com>; keescook@chromium.org; gpiccoli@ig=
alia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien=
8.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-harde=
ning@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@=
nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> External email: Use caution opening links or attachments
>
>
> > Can the maintainers please respond to my patch?
>
> Can you give a reference to the ACPI spec where this timing information i=
s documented? I'm looking at ACPI 6.5 and don't see anything about this.
>
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-s=
erialization
>
> -Tony

