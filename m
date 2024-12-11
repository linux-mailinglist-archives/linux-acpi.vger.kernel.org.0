Return-Path: <linux-acpi+bounces-10085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9FC9EC723
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024B7188C35B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C361D88CA;
	Wed, 11 Dec 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzNMiVir"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E41D6195;
	Wed, 11 Dec 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905645; cv=none; b=LOsS3O/yj5pHuM83G0bOsS9X1w/EC4OCDqpHuqFyLxalL3DaGuEQuBNPrdbYHdx1Fk5bcdBTBR7dyuIx1eUo8Baaq3t5GLt3iOJCdCdvkgnvb4jTs5J3dXM6taIMM03PSnVh5TGfxo/i1S06offJfx8WsMOfONd8jIAAblNkLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905645; c=relaxed/simple;
	bh=HibHtx1M2eii5R14Ci3rh94eU2NfEr5ZCecDbmdZLwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA8QDP8SuXOAnVyQEOHS70TV2ONAdqdzYO6BFnqNErNRXyjzjwzVIcEspX0z+0o1pJ7phIcLUce7ECxnyXat28EhBiF1Skb99C5rrfvmRPEn0YENkPqfNMyj7hvMQdb4LU20SbBmtFuRzdM7MW1rZnpCHGLa6N+M7A7SQMhbsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzNMiVir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5D7C4CED2;
	Wed, 11 Dec 2024 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733905645;
	bh=HibHtx1M2eii5R14Ci3rh94eU2NfEr5ZCecDbmdZLwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UzNMiVir+UO6iRoZPY3I5NbFRfyrvIconF1XKYFt5SnzVqbm0Im+DQbkVB0aSne03
	 8JfprfvP6fWRWiykFJ6V/J9P0FcbF3H8Cs9Oxcu/sab02hQ1fNweu/XY5by8Li4fT0
	 kD0rIokJUmt2P+Gvs3yNwUkiJtw3dgEh8aDvyBmF1xxrjIwDKaSH2ygzZkLqRMEESt
	 q1jfl7Sd24si9Pbz+b+C6qH5ev1tg53CEJhSgjC3iphGVrwvwkrvkG0wZyWzgyanmz
	 Yfrzlh5yA2YbLq9PtFQmUFq1Xn7MnI2EX1jqOr0egaxiztbzjwsx6tFgLgAiVEIYBd
	 j4o3sZFoxnV0w==
Date: Wed, 11 Dec 2024 09:27:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Message-ID: <20241211092719.2dce65dd@foz.lan>
In-Reply-To: <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
	<Z1isvGLLwr7jmW5k@kekkonen.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Dec 2024 21:03:56 +0000
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> Hi Ricardo,
> 
> On Tue, Dec 10, 2024 at 07:55:58PM +0000, Ricardo Ribalda wrote:
> > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > throws the following smatch warning:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> > 
> > Fix it by replacing the condition.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>  
> 
> I've picked this to my tree and I'll take the last one, too, once the rest
> reaches the media tree.

I prefer not merging it via media tree, except if we get an explicit ack
to do so from ACPI maintainers, as most of the stuff here are at ACPI
 headers.

Thanks,
Mauro

