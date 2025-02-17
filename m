Return-Path: <linux-acpi+bounces-11213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399FA388C3
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2025 17:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829A33B281E
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AD225A56;
	Mon, 17 Feb 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1gqs7z1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B24224B11;
	Mon, 17 Feb 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807987; cv=none; b=o3UoOpPjTR+OiJvA7SVOlZ/lTnNIIegbMPHmrzZ4IoUAsvyMpTI2V5lS4A4m+og1g9qxBelnpytAfvpse9bKDVljDiV+GIn6Tiz6uk6NRv+Vx5BTlVkuEKdW2QWAVGxaS5qLqz8R81ttSzc3Hx5jCZlZ7vBaFyYWPhGfRs+7kuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807987; c=relaxed/simple;
	bh=sxam5ianDVRoiz3BZPL6rpG+tKj5gGskh8BEfwDSZ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReBoYfpe/hnWgdxnqFzkHd73/rna3XnfVRyws07ExLgiDbcgUZvYSvwAYqePGU9R8gZ27On/CFhmjZAYlsWqvmbVv5xRoT20m/AyxsWCOIGktMH3iyWn972Tcpu6wzNxTUrPRaYYwzcb5Mxb6x55Rp2VTrzigJVo4+shZ3Pk+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1gqs7z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948BC4CEE9;
	Mon, 17 Feb 2025 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739807986;
	bh=sxam5ianDVRoiz3BZPL6rpG+tKj5gGskh8BEfwDSZ4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1gqs7z1500SCAyqO7HNvLQzshsYY2kuvfa3FnOeW8iXqxwk1rMdXCKAClslRv0KR
	 5x5pANllDnNARtjCeX6NmbzVnQbLUAWLaJwgoFRoYqj/ooznpR+Aqx49Qk5C6GiSXF
	 Hq2u2w0NFSo8I3SbHKgk+b/tj3geWvBbqbb3blQnmMQ45ic22ebu5GXvgB1FBwF6K9
	 EtlZ3ALAnLAwWc5Bxp/O8B/fBI2HVhg0vHvu0bAQlHYGXqR987Lz96E4y+9d+rQYHP
	 H6juWS/5CTwXUfd8d8mNY29y2qCWHgvHIpVFMTYUdX4+Ug/lgYa43SKe9rtYY639aF
	 IEOLDPNhHA20w==
Date: Mon, 17 Feb 2025 17:59:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] tpm_crb: implement driver compliant to CRB over
 FF-A
Message-ID: <Z7Nc7Rs_bny6Bkyn@kernel.org>
References: <20250214002745.878890-1-stuart.yoder@arm.com>
 <20250214002745.878890-2-stuart.yoder@arm.com>
 <Z670QLo_FefvuNb8@kernel.org>
 <195bc518-a20a-487f-b1ad-e83ca9ed5630@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195bc518-a20a-487f-b1ad-e83ca9ed5630@arm.com>

On Mon, Feb 17, 2025 at 09:53:24AM -0600, Stuart Yoder wrote:
> > You probably did not run checkpatch.pl with '--strict', did you? ;-)
> 
> No, did no check with --strict.  Will do that.

Not blaming you :-) I learned it like a year or two ago randomly.

It's very useful option that gives much more deeper information
about various issues.

That said, no need to hit yourself to the wall with it. Sometimes
it also gives errors that are by practical means unreasonable to
resolve.

BR, Jarkko

