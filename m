Return-Path: <linux-acpi+bounces-14200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321DAD0559
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2815E162785
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED4288524;
	Fri,  6 Jun 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYcdotZl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601213DBA0;
	Fri,  6 Jun 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224342; cv=none; b=UywuJ/CQDf6mocX5UWYnPr6tXviHmaoBJtwZ6lSF8MRyvnw2h4JKmujC0TQOz+7Uull4QztmFybrZpD8z83ux563sLJELmQL3uyJDXs3hTcTsOJFDfF2bYZChgqAvbPAZTPJK62jOJjZFvsLA1eG4suFQy+OwoMyI9b8tl0+BmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224342; c=relaxed/simple;
	bh=UGLikP/qZtf4sFlH8DwnQ90HiF5s8Tor/O7KHagFCII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bp+CpdCPWDx3Hwqfe3GUkwdM2qYAQBbAeWEGylbUmFGq568jALjUdfMxRwlCsideIh7xgb1Z/Y1oN5Kwq94OZvrnX6Tvf42o2UxFVY+omUdejCy+wKg7/e4/j9774w2pP3uUiZ6i8cnrYgtPqL5qqllJ0XHLXbpKB/IUldSa5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYcdotZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D22DC4CEEB;
	Fri,  6 Jun 2025 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224342;
	bh=UGLikP/qZtf4sFlH8DwnQ90HiF5s8Tor/O7KHagFCII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fYcdotZlDgIcxkH/gmjVHX8EnV5ANOEwY8ytcA8q4eQxIvAo/UWBbhUX+DFNwt2v2
	 AYptnw+3ludL/ltvelG9/35rShFPbF5FB/6Oef96qRed5lT/MB+fX/HvxdkSKkG64v
	 C+9y+KD/Otg/x4z4ceq3Pu3hsAiIeVfYm16k5yvV4WViyo1xMSu+5s/Wkfy4XPpxBo
	 kzCwDZNxPWh3tU5mozOdKQbp8QTt3OY49i4uiRxv1PnwNFXW0hfZOPRhAUjNtpWK5K
	 BYSeCCAwGzwolY6OT0MhiFlnBub8WL/eQ1ZHjxe0viTzeqMso18idgejLRHlwW4UCE
	 x162QIkqZN7OA==
Message-ID: <ce134894-f33e-4810-97ab-76270438fff7@kernel.org>
Date: Fri, 6 Jun 2025 17:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to Adapter
 trait
To: Igor Korotin <igor.korotin.linux@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@yahoo.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Len Brown <lenb@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605162726.3659792-1-igor.korotin@yahoo.com> <aELyEqg0GrkC8oZY@pollux>
 <CAG7QV91AWpOk7VUcE-B1MLkEQPDB0Y=zsBOBf6MhHVYh1aEGQA@mail.gmail.com>
 <2025060635-unleveled-drowsily-a192@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025060635-unleveled-drowsily-a192@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/6/25 5:29 PM, Greg Kroah-Hartman wrote:
> On Fri, Jun 06, 2025 at 03:26:13PM +0100, Igor Korotin wrote:
>> On Fri, Jun 6, 2025 at 2:50 PM Danilo Krummrich <dakr@kernel.org> wrote:
>>> However, I don't understand why we need this and the subsequent
>>> is_acpi_device_node() and is_of_node() checks.
>>
>> The idea is to avoid unnecessary table lookups when both OF and ACPI
>> match tables are present. If we already know the fwnode type, these
>> simple pointer comparisons (is_acpi_device_node() / is_of_node()) let
>> us skip the irrelevant match function.
>>
>> Those checks are cheap (just pointer comparisons), while
>> acpi_match_device() and of_match_device() iterate over tables.
>>
>> So yeah, it’s a bit ugly, but it can save some CPU cycles during enumeration.
> 
> You have loads of CPU cycles during enumeration, keep things simple
> first, only attempt to optimize things later on if it is actually
> measureable.

I'm fine either way, I don't expect much value in optimizing this and at the
same time I don't see doing it adds significant complexity either.

If Greg prefers not to have this optimization to begin with, let's go without
it please.

