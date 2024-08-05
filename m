Return-Path: <linux-acpi+bounces-7291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E42947CE5
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A0A1C215E2
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBC13AD18;
	Mon,  5 Aug 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuO4dldk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766151016;
	Mon,  5 Aug 2024 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868440; cv=none; b=E7nHFldFPycQ5MqMdeYynfZSx0iPZpNFonTsgrxryqTHPsKqitZfrYJa2N2IpKb8r2fahSLUrwo6xLhuAMSTCjytYSkrb7dwc5ITi29vs7UJIpiplp1r4NqyP0k8+wSvCn3eTbgJuCYk+QXQQkYqwKA40QW56E8LLYE1bCg3hsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868440; c=relaxed/simple;
	bh=RQJnpbRs0eEEw4JTkZwMVrXstajtQEQUHgmNQAJOGPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtkC9DFPAL44QYrIHeAIybs17M0GzEg7uoPHu3P+TcUvUaa444jdo/9y+K9+4duCtDMFzeUUnce3AVDv1KkV96y2Eqxs3mlB268TciZAydqKvtSIY9DXwf3c2C20EWoxn7xqOyJ2fBRiZHm8Yoluu993fDojpXNPRQEGZ83seQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuO4dldk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA038C32782;
	Mon,  5 Aug 2024 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868439;
	bh=RQJnpbRs0eEEw4JTkZwMVrXstajtQEQUHgmNQAJOGPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuO4dldkUm+Yxtqh9eFLtq5Ti3QRHRNrzmaus28juAfBESgtnDptdU7WiH5HFZEiG
	 Jmq74z01Xiq0/BrGxXFQRVR1kVR+754iHhB2w/uCPCF5kOfxmD/ORE4Tl5wNefWDYL
	 qXMOAiv1RItlZE9exPaqYN2V9GxfomP/hPLyiGm7JSaouHjnxsJ1WloHdrhipyia4z
	 EpVncrSbu2lvl3USEdhgcmttUu55mwtSdlAzAKGPLrPQo/8kT/Lq70jn/5EBbKKE/w
	 KtgvX2N0lc19qur2k6TBi9iii9xRRitQGB5/3AKQWlmeV4Jxwnrj85gsgHOFOc6qky
	 wq0cIewF4f1Ig==
Date: Mon, 5 Aug 2024 15:33:52 +0100
From: Lee Jones <lee@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v2 0/6] use device_for_each_child_node() to
 access device child nodes
Message-ID: <20240805143352.GF1019230@google.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
 <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
 <094c7d7f-749f-4d8f-9254-f661090e4350@gmail.com>
 <20240801123901.GC6756@google.com>
 <9083938c-c2df-4429-904d-700e5021331c@gmail.com>
 <20240805143207.GE1019230@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805143207.GE1019230@google.com>

On Mon, 05 Aug 2024, Lee Jones wrote:

> On Fri, 02 Aug 2024, Javier Carrasco wrote:
> 
> > On 01/08/2024 14:39, Lee Jones wrote:
> > > On Mon, 29 Jul 2024, Javier Carrasco wrote:
> > > 
> > >> On 25/07/2024 18:28, Lee Jones wrote:
> > >>> On Sun, 21 Jul 2024 17:19:00 +0200, Javier Carrasco wrote:
> > >>>> This series aims to clarify the use cases of:
> > >>>>
> > >>>> - device_for_each_child_node[_scoped]()
> > >>>> - fwnode_for_each_available_child_node[_scoped]()
> > >>>>
> > >>>> to access firmware nodes.
> > >>>>
> > >>>> [...]
> > >>>
> > >>> Applied, thanks!
> > >>>
> > >>> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
> > >>>       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
> > >>> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
> > >>>       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
> > >>> [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
> > >>>       (no commit info)
> > >>>
> > >>> --
> > >>> Lee Jones [李琼斯]
> > >>>
> > >>
> > >> Hi Lee,
> > >>
> > >> could you please tell me where you applied them? I rebased onto
> > >> linux-next to prepare for v3, and these patches are still added on top
> > >> of it. Can I find them in some leds/ branch? Thank you.
> > > 
> > > Sorry, I was side-tracked before pushing.
> > > 
> > > Pushed now.  They should be in -next tomorrow.
> > > 
> > 
> > Thanks, I see
> > 
> > [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
> > 
> > [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to
> > access child nodes
> > 
> > applied to -next, but
> > 
> > [5/6] leds: pca995x: use device_for_each_child_node() to access device
> > child nodes
> > 
> > has not been applied yet.
> 
> Yep, looks like b4 didn't like that one:
> 
> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
>       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
>       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
> [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
>       (no commit info)
> 
> I'll try again and see if it can be pulled in.
> 
> If not you'll have to resubmit it.

Now results in conflict:

    Applying patch(es)
    Applying: leds: pca995x: use device_for_each_child_node() to access device child nodes
    Using index info to reconstruct a base tree...
    M	drivers/leds/leds-pca995x.c
    Checking patch drivers/leds/leds-pca995x.c...
    Applied patch drivers/leds/leds-pca995x.c cleanly.
    Falling back to patching base and 3-way merge...
    error: Your local changes to the following files would be overwritten by merge:
    	drivers/leds/leds-pca995x.c
    Please commit your changes or stash them before you merge.
    Aborting
    error: Failed to merge in the changes.
    Patch failed at 0001 leds: pca995x: use device_for_each_child_node() to access device child nodes
    hint: Use 'git am --show-current-patch=diff' to see the failed patch
    hint: When you have resolved this problem, run "git am --continue".
    hint: If you prefer to skip this patch, run "git am --skip" instead.
    hint: To restore the original branch and stop patching, run "git am --abort".
    hint: Disable this message with "git config advice.mergeConflict false"
    
    Failed to apply patches (fix and either hit return to continue or Ctrl+c to exit)

Please rebase and resubmit.

-- 
Lee Jones [李琼斯]

