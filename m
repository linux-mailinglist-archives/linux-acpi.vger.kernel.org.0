Return-Path: <linux-acpi+bounces-9198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943399B7D0D
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535C0281E6E
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD21A073F;
	Thu, 31 Oct 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5K4f5fW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561419C556;
	Thu, 31 Oct 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385459; cv=none; b=g5exGW4+c5jXBOFQ3S8+PsjOILRuaqMMJqqOKtBOSlztYy9hxXf8rEMMVxpu1FgmqoYeHEht9vCsIhCyxIE525GzVgpK/XqP63Py+aPnftVWVENI1NBUwvHYB0eCmLrPXv4Fa8KY6RfKYvevbKFHRC2r1UmQB62mFCEf0GX7qgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385459; c=relaxed/simple;
	bh=eRfzzU7Y4YIFR/gbChiOoc36llvu+XnhL4vpNp490ls=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GtR2CXzYp29auchGsZz6fbPUt9scoKaN/p29ViIXmM1oerloWipW+LKe4dyiRDm6h+x5MAVQVk2zGsksJkg+cm8dQthHQQrG3+h5Dm6jRt9tYPL4SAiNeRTvyvQInSiLvSRRz5OYwcRiTQYyM09TDfR1X7kAct3IeimxuQhzzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5K4f5fW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730385457; x=1761921457;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=eRfzzU7Y4YIFR/gbChiOoc36llvu+XnhL4vpNp490ls=;
  b=O5K4f5fW0OEsQgafEBwF9vlNgfXPl2hGeeFxrP9MbF04v3Ko6GcPzU+V
   8G3mF2YAP/JEf/sLN+QupfI9ANnu3gk6FE0IxY4TyxmYAjx91P6H6D00C
   tsuTaO6bjSxFQUSZtD5mhTI2Sh+JVFcXYkSnO1/dlwzMZ9jVsdQxeVXar
   MTWYOxPGyQmYm2Jn9XHjNGYAlwfwvvW1vlaHkrZ5nCIE3DDlBdyBAV/8Q
   gMBZSPwAK9Ne2WeOV1EBwOoZko4mZPh3ggEAG7MPWWsUa9usEudQwkhpr
   DK4lPtc6eCr+XuMmcSMj6zT5DjIo3UAXCuw6gPsWP6IyDXEiA9RupGKSp
   g==;
X-CSE-ConnectionGUID: QeBTmxD9QjyL6Bf+ToTcQw==
X-CSE-MsgGUID: jlrdfVMRQdir2ZC47j9U6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30342952"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30342952"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:37:36 -0700
X-CSE-ConnectionGUID: CgLXysXHQ++XgolJCKLHlQ==
X-CSE-MsgGUID: 9dpsncoXS6a/lyAuIIEAXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="86563874"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:37:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 16:37:26 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH v3 16/22] ACPI: platform_profile: Set profile for all
 registered handlers
In-Reply-To: <362d8939-20ed-40c2-95b4-f687dc20f6cc@amd.com>
Message-ID: <0fd4c5ec-3645-300e-baee-cb6468039f75@linux.intel.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com> <20241031040952.109057-17-mario.limonciello@amd.com> <7e2c26ab-9172-fa82-cd96-7f725d6c7687@linux.intel.com> <362d8939-20ed-40c2-95b4-f687dc20f6cc@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-364525015-1730385262=:939"
Content-ID: <d485431b-9418-e081-4e25-b15ce09f2744@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-364525015-1730385262=:939
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <082be37d-f769-5437-5cec-9d8440aa3114@linux.intel.com>

On Thu, 31 Oct 2024, Mario Limonciello wrote:

> On 10/31/2024 05:25, Ilpo J=E4rvinen wrote:
> > On Wed, 30 Oct 2024, Mario Limonciello wrote:
> >=20
> > > If multiple platform profile handlers have been registered then when
> > > setting a profile verify that all profile handlers support the reques=
ted
> > > profile and set it to each handler.
> > >=20
> > > If this fails for any given handler, revert all profile handlers back=
 to
> > > balanced and log an error into the kernel ring buffer.
> > >=20
> > > Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/acpi/platform_profile.c | 25 ++++++++++++++++++++-----
> > >   1 file changed, 20 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/platform_profile.c
> > > b/drivers/acpi/platform_profile.c
> > > index 90cbc0de4d5bc..c2bb325ba531c 100644
> > > --- a/drivers/acpi/platform_profile.c
> > > +++ b/drivers/acpi/platform_profile.c
> > > @@ -99,6 +99,8 @@ static ssize_t platform_profile_store(struct device
> > > *dev,
> > >   =09=09=09    struct device_attribute *attr,
> > >   =09=09=09    const char *buf, size_t count)
> > >   {
> > > +=09struct platform_profile_handler *handler;
> > > +=09unsigned long choices;
> > >   =09int err, i;
> > >     =09/* Scan for a matching profile */
> > > @@ -107,16 +109,29 @@ static ssize_t platform_profile_store(struct de=
vice
> > > *dev,
> > >   =09=09return -EINVAL;
> > >     =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
> > > &profile_lock) {
> > > -=09=09if (!cur_profile)
> > > +=09=09if (!platform_profile_is_registered())
> > >   =09=09=09return -ENODEV;
> > >   -=09=09/* Check that platform supports this profile choice */
> > > -=09=09if (!test_bit(i, cur_profile->choices))
> > > +=09=09/* Check that all handlers support this profile choice */
> > > +=09=09choices =3D platform_profile_get_choices();
> > > +=09=09if (!test_bit(i, &choices))
> > >   =09=09=09return -EOPNOTSUPP;
> > >   -=09=09err =3D cur_profile->profile_set(cur_profile, i);
> > > -=09=09if (err)
> > > +=09=09list_for_each_entry(handler, &platform_profile_handler_list,
> > > list) {
> > > +=09=09=09err =3D handler->profile_set(handler, i);
> > > +=09=09=09if (err) {
> > > +=09=09=09=09pr_err("Failed to set profile for handler
> > > %s\n", handler->name);
> > > +=09=09=09=09break;
> > > +=09=09=09}
> > > +=09=09}
> > > +=09=09if (err) {
> > > +=09=09=09list_for_each_entry_continue_reverse(handler,
> > > &platform_profile_handler_list, list) {
> >=20
> > Too long line.
> >=20
> > This looks an error rollback though so instead of break inside the loop
> > you could goto into a label at the end of the function and have much le=
ss
> > indentation to begin with.
>=20
> How does the scoped_cond_guard interact with a goto?  With the jump I had
> guessed it goes out of scope, but I wasn't really sure what the compiler =
does.
>=20
> I guess in the goto label I'll need another scoped_cond_guard()?

Ah, the scope problem is a good point.

Perhaps you could instead add e.g. platform_profile_reset_default() and=20
call that before break, both patches that had the rollback did the same=20
thing anyway so it can be reused too.

--=20
 i.
--8323328-364525015-1730385262=:939--

