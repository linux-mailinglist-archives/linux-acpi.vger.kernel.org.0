Return-Path: <linux-acpi+bounces-8699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FE999A81
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1D71F24500
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8331F4700;
	Fri, 11 Oct 2024 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2zPxLcq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233D17BA9;
	Fri, 11 Oct 2024 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614211; cv=none; b=GfhIRJD+ZqjJQjw2O+2r1suBiBxeOwWlNnW++IYpEA+DDuKVt1yPSbQAjOeO3184p/Lchwwp60Gi8Lg8G6vAqvTqKEUzCCHjTUiBaXbHVKVsN2KWtnHs9obtkayT+LhwWAzXBANijUIw6xnwnv0Q3MUkA21tV2foiEg2Nd73vTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614211; c=relaxed/simple;
	bh=HZMq8iPUueyAfT9QGmVHcPYapGVBFuxssBVnL5qeNX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUU4wrSAxBc7zAHVOnQgnFCpiP3jWHbxF24Iy5PDTmb8x/3/M61fxqB+JkAgaDQTJ/xSG6n5pIU4jQZyYOK+cw4yO7Z6kBqfFNClZ3RW0ftdWWlBXeGgHVa0Li8U1X7sj1Oc10kEhJ6/Md2G+i6zL7RRnB5NE2u1WQJkpbXpUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2zPxLcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E88FC4CEC5;
	Fri, 11 Oct 2024 02:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614210;
	bh=HZMq8iPUueyAfT9QGmVHcPYapGVBFuxssBVnL5qeNX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2zPxLcqz8o0EyI4kA10QCt4X+Q2kBcqidTV9fSIRFQ/tnSHO8IWe8EgVKMYj2jEy
	 hck5ZUh3AVuE5/mzj4C3xwZ8yW19S4hPHuo70C5lndNHAL7GWsMbR0qdP172eCzGeB
	 CCzuWmC7h2OJwFPCWeCpz/zVk/IGljHnsJWabIxzZQ0xXt7l+nyC6KZQzN3QqV9MEc
	 x4U2NP4nrPwnqwJoTJL6HjygYzS3kFK7ZS6eXndzaT7nJP7aUQ4IQon6+l2Kr/NYzO
	 Kv8fy/BSBwsdU1RNHdQK7ZG3U5aT1avX8dmC93xfaJ8xnlTViq18Kr6EY4uqrOuAHO
	 tqCYC2IzCeo4w==
Date: Fri, 11 Oct 2024 10:36:46 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 6/8] power: supply: lenovo_yoga_c630_battery: register
 power supplies with power_supply_register()
Message-ID: <ZwiPPv_3R8TvtG4W@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-6-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-6-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:08PM +0200, Thomas Weiﬂschuh wrote:
> {,devm_}power_supply_register_no_ws() are going to be removed.
> Switch to the general registration API.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

