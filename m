Return-Path: <linux-acpi+bounces-6354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D1905C82
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 22:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731D31C21366
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33084A30;
	Wed, 12 Jun 2024 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="N+ZCQN09"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A44F8BB;
	Wed, 12 Jun 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222928; cv=none; b=cFgj3YW5MLF52qDDVSibrH9bp80b68YYfUJVahPeredHThPGTSGwo5U8hkPn/iILicMwiDH0psHNyXpywv/adm7Wk76e57srMQQIM+H+0lLKKbIyd9O8uspDYdfm4dziQ2Wej8Cu3KaLLhwJQCG5suLzeqVeypw4qHphQL3fgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222928; c=relaxed/simple;
	bh=YtbPsXWtEDrY++ARfDvNYAfet227CXa/oD480skBvMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snYO0uVxM4wfL2W6k/GC99z8RxrbnHdmug40YDyNyx7Otw9zvcVdWNt68wVjFdul9vqplyDc4fnUGaR9si7TKj3uRaFBOCfJTpeRIBYAfWwahMQrwAnskFxOpkt/ssphsCDFBCcpWRJAG8vGZLa7NVcf7HPS0hrnQ6BolLaUKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=N+ZCQN09; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A4C9124F;
	Wed, 12 Jun 2024 22:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718222912;
	bh=YtbPsXWtEDrY++ARfDvNYAfet227CXa/oD480skBvMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+ZCQN09U/IsYIlZfPebDWD/rNnC5w6brldYBOyG6AqZkSiUijVHKu3wCW6vozJVt
	 Ih9jg47AfkTZVLBiCAbwCOZd8jaZofiKPEdfcwQPzIiHpsU2PJPBqeT66+hW7zzY7K
	 hu3CWpurC7p2Yl5g1v5WGOm0HPqwVQnHXvTbHL/E=
Date: Wed, 12 Jun 2024 23:08:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, wentong.wu@intel.com,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <20240612200825.GR28989@pendragon.ideasonboard.com>
References: <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
 <20240612143956.GN28989@pendragon.ideasonboard.com>
 <CAJZ5v0hFYSQic3N2KWGzyrX-K4KX9Okt20NtXmqRuutc140HUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hFYSQic3N2KWGzyrX-K4KX9Okt20NtXmqRuutc140HUw@mail.gmail.com>

Hi Rafael,

On Wed, Jun 12, 2024 at 09:07:09PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2024 at 4:40 PM Laurent Pinchart wrote:
> > On Wed, Jun 12, 2024 at 04:30:30PM +0200, Hans de Goede wrote:
> > > On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus wrote:
> > > >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > >>>>>>> I just hit the same problem on another Dell laptop. It seems that
> > > >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > >>>>>>> and Raptor Lake generations suffer from this problem.
> > > >>>>>>>
> > > >>>>>>> So instead of playing whack a mole with DMI matches we should
> > > >>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptops
> > > >>>>>>> with those CPUs. I'm preparing a fix for this to replace
> > > >>>>>>> the DMI matching now.
> > > >>>>>>
> > > >>>>>> DisCo for Imaging support shouldn't be dropped on these systems, and this
> > > >>>>>> isn't what your patch does either. Instead the ACPI graph port nodes (as
> > > >>>>>> per Linux specific definitions) are simply dropped, i.e. this isn't related
> > > >>>>>> to DisCo for Imaging at all.
> > > >>>>>
> > > >>>>> So it looks like the changelog of that patch could be improved, right?
> > > >>>>
> > > >>>> Well, yes. The reason the function is in the file is that nearly all camera
> > > >>>> related parsing is located there, not that it would be related to DisCo for
> > > >>>> Imaging as such.
> > > >>>
> > > >>> So IIUC the camera graph port nodes are created by default with the
> > > >>> help of the firmware-supplied information, but if that is defective a
> > > >>> quirk can be added to skip the creation of those ports in which case
> > > >>> they will be created elsewhere.
> > > >>>
> > > >>> Is this correct?
> > > >>
> > > >> Yes.
> > > >
> > > > So it would be good to add a comment to this effect to
> > > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > > called.
> > > >
> > > > And there is a somewhat tangential question that occurred to me: If
> > > > the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> > > > why is it necessary to consult the platform firmware for the
> > > > information on them at all?  Wouldn't it be better to simply always
> > > > create them elsewhere?
> > >
> > > That is a good question. The ACPI MIPI DISCO specification is an
> > > attempt standardize how MIPI cameras and their sensors are described
> > > in ACPI.
> > >
> > > But this is not actually being used by any Windows drivers atm. The windows
> > > drivers rely on their own custom ACPI data which gets translated into
> > > standard Linux device-properties by: drivers/media/pci/intel/ipu-bridge.c
> > >
> > > and so far AFAIK there are 0 laptops where there actually is 100% functional
> > > ACPI MIPI information. I believe that some work is in place to get correct
> > > usable ACPI MIPI information in place in the ACPI tables of some Meteor Lake
> > > laptops. But I believe that there too it does not work yet with the BIOS
> > > version with which current Windows models are shipping. It is being fixed
> > > for systems which have Linux support from the vendor but I suspect that
> >
> > I think it's shipped in Chrome Books. Sakari can confirm.
> >
> > > on other models if ACPI MIPI DISCO information is there it will not
> > > necessarily be reliable because AFAICT Windows does not actually use it.
> > >
> > > And TBH this has me worried about camera support for Meteor Lake devices
> > > going forward. We really need to have 1 reliable source of truth here and
> > > using information which is ignored by Windows does not seem like the best
> > > source to use.
> >
> > As long as the Windows drivers don't use the ACPI data that Linux uses,
> > you can be 100% sure it will be wrong. That will never be fixed if Intel
> > doesn't address the issue on their side, and effort we would put in
> > standardizing that data for machines shipped by Windows OEMs is a waste
> > of time in my opinion. Our only option, given Intel's failure, is to
> > keep reverse-engineering camera support per machine for the time being
> > (sometimes with the help of OEMs).
> 
> So while I kind of agree with you on the technical side (as you can
> see from my messages in this thread), there is one thing in the above
> paragraph that I need to react to.
> 
> Namely, both I and Sakari are Intel employees.  Do you think or are
> you suggesting that we are somehow responsible for this failure?
> Because I personally don't think like I have anything to do with it.

That's a worthy clarification: I blame neither you nor Sakari, quite the
contrary. As far as I can tell, both of you have done and are doing your
best to fix this kind of issues. Sakari has helped standardizing DisCo
for Imaging for instance, which was the best outcome we could
realistically hope for in this context. Intel is a large company, and as
with any large company, some people end up having to try and fix the
mess created by others :-S I'm sorry it's falling on you and Sakari.

> What do you mean, specifically, by saying "if Intel doesn't address
> the issue on their side"?  And who at Intel do I need to talk to about
> this?

I think you would need to get the Windows and Linux side of the Intel
team(s) responsible for camera drivers and ACPI integration, along with
a manager who can understand the problem, the bad PR, and get the
stakeholders to cooperate and do better in the future. I don't know who
that would be though, what I know is that it doesn't seem the issue will
solve itself without someone with decision power decides to fix it.

-- 
Regards,

Laurent Pinchart

