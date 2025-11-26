Return-Path: <linux-acpi+bounces-19274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C8C88714
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 08:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BC504E274A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5652BCF5D;
	Wed, 26 Nov 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q+wD/bkn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA26246BD5;
	Wed, 26 Nov 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142690; cv=none; b=OFkhCVS0HlN1Q7xKRam4bKL7rin48Eu2FF77TNImkfER1I66fZV/ERU8qWPKYL1KRqams1+nM21mh8NeqQ2CMa8VsSYFCn1YZpTIEJWT+7vIIkBp5DNfa5ikrX6f9Snr+KrZKuD5VkYlPN6+kEAFp4NiLUa7HFvrH+1eE+ZIfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142690; c=relaxed/simple;
	bh=u2/8o+93/7lAGtmlFeXczNKd2oyHcucjDMBdhkz4rkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmGpY+x1VzXXonALew1fW2Kamc3QJzsGkEOSZYoiXpMHDiY1HyCD10cshNFmfJNJ81Wp8HlNCXkLRwaovbmeHwFU9n4zJ9Fv+t6BMyLKqsDzxXWrKUy0i4mO7qqFJh18VLTsTAYi6vd2mWZxyRBj59Smsy8LQiQQ9W9IyjUWI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q+wD/bkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66762C113D0;
	Wed, 26 Nov 2025 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764142690;
	bh=u2/8o+93/7lAGtmlFeXczNKd2oyHcucjDMBdhkz4rkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+wD/bkntqnQTHZkOioO0AunDRzjZ+Gqs4DR8Tt2j/SPKLaBlrlbDt+GdIi4w8zk7
	 /w4QVlAVPqqv9ypRPaUFs0g7Hl1kdpjKFR15mXrrNIGCOGZlzVlatqt03i6gfdlM3E
	 VghY5A1Zn8Pk5UnK89hSwmw9ef0AM/Zzh4SZeax0=
Date: Wed, 26 Nov 2025 08:38:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org, kernel@collabora.com,
	superm1@kernel.org
Subject: Re: [PATCH 2/4] ACPI: button: Cancel hibernation if button is
 pressed during hibernation
Message-ID: <2025112612-backup-driving-e6e6@gregkh>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
 <2025112433-emphasize-helpful-b748@gregkh>
 <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>
 <2025112506-acting-tipoff-3a49@gregkh>
 <cef1d96b-b642-4e69-8c1b-2e0bf7528edf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef1d96b-b642-4e69-8c1b-2e0bf7528edf@collabora.com>

On Tue, Nov 25, 2025 at 09:41:22PM +0500, Muhammad Usama Anjum wrote:
> >> While I've thought about increasing the speed, I've no concrete ideas yet.
> >> The main problem is that its sequential in nature.
> > 
> > Then fix that?
> That's in the plan. But who knows when we get time to attempt that. 

Take the time to fix this properly first, don't paper over the issue by
changing user/system interactions that will not be needed in the future
when the real problem is resolved.

> First I need a board/machine with serial console access to view all logs in real
> time. :)

usb debug cables might be your solution.

good luck!

greg k-h

