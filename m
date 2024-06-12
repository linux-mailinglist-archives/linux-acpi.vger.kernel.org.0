Return-Path: <linux-acpi+bounces-6334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B68490555B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206972836E2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BF17E463;
	Wed, 12 Jun 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wJr6F2t1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6417DE34;
	Wed, 12 Jun 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203222; cv=none; b=mhktHb2FWOMOfSJnejFrozJzMW06Uh1ip3HGcQwiRvWx3MQg3I7iQePdX8TqAhHK1UApIZgqVkHVFeR6YhP9MxUrQqvjeSp/ueVEr2N7/kQ31awbxZUwou9wT53BwHVEE6TiWbKPJiZ+htsgbzobUPykuGNifZUBJAN+ObATzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203222; c=relaxed/simple;
	bh=JPNJmCvj0/G+NJcBj5UdicW55buFti9R+yrbgiH8D/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnNnveT+r/uXbhAuhIWR85d1tsc+mQNbxb6UBLz/t4T+oeU6bQ2Nr0BjR9VbnZWuCmdDLUmdwkJR8lAoioU1gM6ZP2iM92EwR7X/ka0EdZwam/0sSQqgEfxOsrL8FaHMBsFwS/19KcQv0y/eHE6J0tL0HpkIsCxWYbFi521ACAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wJr6F2t1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5B3429A;
	Wed, 12 Jun 2024 16:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718203203;
	bh=JPNJmCvj0/G+NJcBj5UdicW55buFti9R+yrbgiH8D/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wJr6F2t1UjHrDJkj3IdB3qb/VJJ0SPbrJzZgNOlR7UYyN+KaFEjudY0ky6g7V/sKc
	 W7Yz4gnJBJ0ewejY8zhIvZbdFPYKbzORCZKgE2QR6vgtnjiHWSVwQUmNkQ2Xw3uZjq
	 m6TewdaS51KybIlwpVY/HMSL5ul3wqQgtg0Unjm0=
Date: Wed, 12 Jun 2024 17:39:56 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, wentong.wu@intel.com,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <20240612143956.GN28989@pendragon.ideasonboard.com>
References: <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>

On Wed, Jun 12, 2024 at 04:30:30PM +0200, Hans de Goede wrote:
> On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus wrote:
> >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> >>>>>>> I just hit the same problem on another Dell laptop. It seems that
> >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> >>>>>>> and Raptor Lake generations suffer from this problem.
> >>>>>>>
> >>>>>>> So instead of playing whack a mole with DMI matches we should
> >>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptops
> >>>>>>> with those CPUs. I'm preparing a fix for this to replace
> >>>>>>> the DMI matching now.
> >>>>>>
> >>>>>> DisCo for Imaging support shouldn't be dropped on these systems, and this
> >>>>>> isn't what your patch does either. Instead the ACPI graph port nodes (as
> >>>>>> per Linux specific definitions) are simply dropped, i.e. this isn't related
> >>>>>> to DisCo for Imaging at all.
> >>>>>
> >>>>> So it looks like the changelog of that patch could be improved, right?
> >>>>
> >>>> Well, yes. The reason the function is in the file is that nearly all camera
> >>>> related parsing is located there, not that it would be related to DisCo for
> >>>> Imaging as such.
> >>>
> >>> So IIUC the camera graph port nodes are created by default with the
> >>> help of the firmware-supplied information, but if that is defective a
> >>> quirk can be added to skip the creation of those ports in which case
> >>> they will be created elsewhere.
> >>>
> >>> Is this correct?
> >>
> >> Yes.
> > 
> > So it would be good to add a comment to this effect to
> > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > called.
> > 
> > And there is a somewhat tangential question that occurred to me: If
> > the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> > why is it necessary to consult the platform firmware for the
> > information on them at all?  Wouldn't it be better to simply always
> > create them elsewhere?
> 
> That is a good question. The ACPI MIPI DISCO specification is an
> attempt standardize how MIPI cameras and their sensors are described
> in ACPI.
> 
> But this is not actually being used by any Windows drivers atm. The windows
> drivers rely on their own custom ACPI data which gets translated into
> standard Linux device-properties by: drivers/media/pci/intel/ipu-bridge.c 
> 
> and so far AFAIK there are 0 laptops where there actually is 100% functional
> ACPI MIPI information. I believe that some work is in place to get correct
> usable ACPI MIPI information in place in the ACPI tables of some Meteor Lake
> laptops. But I believe that there too it does not work yet with the BIOS
> version with which current Windows models are shipping. It is being fixed
> for systems which have Linux support from the vendor but I suspect that

I think it's shipped in Chrome Books. Sakari can confirm.

> on other models if ACPI MIPI DISCO information is there it will not
> necessarily be reliable because AFAICT Windows does not actually use it.
> 
> And TBH this has me worried about camera support for Meteor Lake devices
> going forward. We really need to have 1 reliable source of truth here and
> using information which is ignored by Windows does not seem like the best
> source to use.

As long as the Windows drivers don't use the ACPI data that Linux uses,
you can be 100% sure it will be wrong. That will never be fixed if Intel
doesn't address the issue on their side, and effort we would put in
standardizing that data for machines shipped by Windows OEMs is a waste
of time in my opinion. Our only option, given Intel's failure, is to
keep reverse-engineering camera support per machine for the time being
(sometimes with the help of OEMs).

> Sakari I know you have been pushing for MIPI camera descriptions under
> ACPI to move to a standardized format and I can see how that is a good
> thing, but atm it seems to mainly cause things to break and before
> the ACPI MIPI DISCO support landed in 6.8 we did not have these issues,
> since the information used by the ipu-bridge code does seem to be correct.

-- 
Regards,

Laurent Pinchart

